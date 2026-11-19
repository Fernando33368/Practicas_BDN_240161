-- Caso de prueba 2: "Compra con detalles en el ultimo pago y con reclamacion y envio"
USE db_test_240161;

-- Tomar usuario existente
SELECT ID INTO @user2 FROM tb_users WHERE status = b'1' ORDER BY ID DESC LIMIT 1;

-- 1. Crear carrito y agregar 10 productos aleatorios (cantidad entre 1 y 5)
INSERT INTO tb_carts (user_ID, status)
VALUES (@user2, b'1')
ON DUPLICATE KEY UPDATE status = b'1';

SELECT ID INTO @cart2 FROM tb_carts WHERE user_ID = @user2 LIMIT 1;

DELETE FROM tbd_cart_items WHERE cart_ID = @cart2;

INSERT INTO tbd_cart_items (cart_ID, product_ID, quantity, unit_price, status, last_update)
SELECT @cart2, ID, FLOOR(1 + (RAND() * 5)), current_price, b'1', NOW()
FROM tb_products
WHERE status = b'1'
ORDER BY RAND()
LIMIT 10;

-- 2. Crear orden (en tb_orders y tb_buyer_orders) y dirección alterna (ej. Trabajo)
SELECT user_ID INTO @seller2 FROM tbd_products_users_providers LIMIT 1;

-- 2A. Orden en tb_buyer_orders (para el seguimiento de entrega)
INSERT INTO tb_buyer_orders (seller_ID, subtotal, shipping_cost, fulfillment_status, status)
VALUES (COALESCE(@seller2, 1), 6000.00, 150.00, 'Pending', b'1');

SET @buyer_order2 = LAST_INSERT_ID();

-- 2B. Orden padre en tb_orders (UBICACIÓN EXACTA: debe ir antes de tbd_order_items)
INSERT INTO tb_orders (user_ID, order_number, total_amount, order_status, status, last_update)
VALUES (@user2, CONCAT('ORD-C2-', UNIX_TIMESTAMP()), 6000.00, 'Pending', b'1', NOW());

SET @order2 = LAST_INSERT_ID();

-- 2C. Copiar los productos del carrito hacia tbd_order_items usando @order2
INSERT INTO tbd_order_items (order_ID, product_ID, quantity, unit_price, status, last_update)
SELECT @order2, ci.product_ID, ci.quantity, ci.unit_price, b'1', NOW()
FROM tbd_cart_items ci
WHERE ci.cart_ID = @cart2;

-- 2D. Registrar dirección alterna
INSERT INTO tb_user_addresses (user_ID, label, is_default, status)
VALUES (@user2, 'Trabajo', 0, b'1');

SET @addr2 = LAST_INSERT_ID();

INSERT INTO tbd_address_components (address_ID, value, component_type, status)
VALUES (@addr2, 'Av. Reforma 450, Oficina 3B', 'street', b'1');

-- 3. Registrar tarjeta de crédito (16 dígitos)
INSERT IGNORE INTO tbc_payment_method_types (code, description, status, last_update)
VALUES ('CREDIT', 'Tarjeta de credito', b'1', NOW());

SELECT ID INTO @pm_type_credit FROM tbc_payment_method_types WHERE code = 'CREDIT' LIMIT 1;

INSERT INTO tbd_user_payment_methods (
    user_ID, payment_method_type_ID, provider, provider_method_ref, label, last_four, is_default, status
)
VALUES (@user2, @pm_type_credit, 'Santander', '5500111122223333', 'Credito', '3333', 0, b'1');

SET @upm2 = LAST_INSERT_ID();

-- 4. Registrar 6 pagos mensuales en tb_payments (incluyendo last_update)
INSERT INTO tb_payments (user_ID, payment_method_type_ID, user_payment_method_ID, total_amount, currency, status, last_update)
VALUES
    (@user2, @pm_type_credit, @upm2, 1000.00, 'MXN', b'1', NOW()),
    (@user2, @pm_type_credit, @upm2, 1000.00, 'MXN', b'1', NOW()),
    (@user2, @pm_type_credit, @upm2, 1000.00, 'MXN', b'1', NOW()),
    (@user2, @pm_type_credit, @upm2, 1000.00, 'MXN', b'1', NOW()),
    (@user2, @pm_type_credit, @upm2, 1000.00, 'MXN', b'1', NOW()),
    (@user2, @pm_type_credit, @upm2, 1000.00, 'MXN', b'1', NOW());

SET @pay2_first = LAST_INSERT_ID();

-- 5. Primeros 5 pagos completados y el 6.º fallido por límite excedido de crédito
INSERT INTO tb_payment_transaction (
    payment_ID, transaction_type, amount, currency, gateway_transaction_id, gateway_response, operation_status, status, last_update
)
VALUES
    (@pay2_first,     'Charge', 1000.00, 'MXN', 'TXN_C2_1', 'APPROVED', 'Completed', b'1', NOW()),
    (@pay2_first + 1, 'Charge', 1000.00, 'MXN', 'TXN_C2_2', 'APPROVED', 'Completed', b'1', NOW()),
    (@pay2_first + 2, 'Charge', 1000.00, 'MXN', 'TXN_C2_3', 'APPROVED', 'Completed', b'1', NOW()),
    (@pay2_first + 3, 'Charge', 1000.00, 'MXN', 'TXN_C2_4', 'APPROVED', 'Completed', b'1', NOW()),
    (@pay2_first + 4, 'Charge', 1000.00, 'MXN', 'TXN_C2_5', 'APPROVED', 'Completed', b'1', NOW()),
    (@pay2_first + 5, 'Charge', 1000.00, 'MXN', 'TXN_C2_6', 'REJECTED: Limite excedido de credito', 'Failed', b'1', NOW());

-- 6. Atención, entrega en casa, reclamo/devolución por producto dañado y reenvío
UPDATE tb_buyer_orders
SET fulfillment_status = 'Delivered'
WHERE ID = @buyer_order2;

SELECT product_ID INTO @prod2_dmg FROM tbd_order_items WHERE order_ID = @order2 LIMIT 1;

INSERT INTO tb_returns (payment_ID, product_ID, user_ID, quantity, return_reason, return_status, status, last_update)
VALUES (@pay2_first, @prod2_dmg, @user2, 1, 'Producto danado al recibir', 'Accepted', b'1', NOW());

SET @ret2 = LAST_INSERT_ID();

INSERT INTO tbd_return_items (return_ID, product_ID, quantity, item_condition, status, last_update)
VALUES (@ret2, @prod2_dmg, 1, 'Damaged', b'1', NOW());

-- Reenvío mediante registro en tb_shipments
INSERT INTO tb_shipments (payment_ID, shipping_company, tracking_number, shipping_cost, shipping_status, status, last_update)
VALUES (@pay2_first, 'E-commerce Logistics', 'REENVIO_001', 0.00, 'Shipped', b'1', NOW());