-- Caso de Prueba 3: "Compra exitosa con cancelacion parcial, aguste y reembolso parcial"
USE db_test_240161;

SELECT ID INTO @user3 FROM tb_users WHERE status = b'1' ORDER BY ID DESC LIMIT 1;

-- Tomar una categoría con al menos 3 productos
SELECT category_ID INTO @cat3
FROM tbd_products_categories
WHERE status = b'1'
GROUP BY category_ID
HAVING COUNT(*) >= 3
LIMIT 1;

-- 1. Carrito con 3 productos de la misma categoría (cantidad entre 1 y 10)
INSERT INTO tb_carts (user_ID, status)
VALUES (@user3, b'1')
ON DUPLICATE KEY UPDATE status = b'1';

SELECT ID INTO @cart3 FROM tb_carts WHERE user_ID = @user3 LIMIT 1;

DELETE FROM tbd_cart_items WHERE cart_ID = @cart3;

INSERT INTO tbd_cart_items (cart_ID, product_ID, quantity, unit_price, status, last_update)
SELECT @cart3, p.ID, FLOOR(1 + (RAND() * 10)), p.current_price, b'1', NOW()
FROM tb_products p
JOIN tbd_products_categories pc ON pc.product_ID = p.ID
WHERE pc.category_ID = @cat3 AND p.status = b'1'
LIMIT 3;

-- 2. Orden y dirección alterna ("Casa Papas")
SELECT SUM(quantity * unit_price) INTO @sub3
FROM tbd_cart_items
WHERE cart_ID = @cart3;

SELECT user_ID INTO @seller3 FROM tbd_products_users_providers LIMIT 1;

-- 2A. Orden en tb_buyer_orders (se guarda su ID en @buyer_order3 para los UPDATE posteriores)
INSERT INTO tb_buyer_orders (seller_ID, subtotal, shipping_cost, fulfillment_status, status)
VALUES (COALESCE(@seller3, 1), COALESCE(@sub3, 3000.00), 100.00, 'Pending', b'1');

SET @buyer_order3 = LAST_INSERT_ID();

-- 2B. Orden padre en tb_orders (justo antes de tbd_order_items)
INSERT INTO tb_orders (user_ID, order_number, total_amount, order_status, status, last_update)
VALUES (@user3, CONCAT('ORD-C3-', UNIX_TIMESTAMP()), COALESCE(@sub3, 3000.00), 'Pending', b'1', NOW());

SET @order3 = LAST_INSERT_ID();

-- 2C. Copiar los productos del carrito hacia tbd_order_items usando @order3
INSERT INTO tbd_order_items (order_ID, product_ID, quantity, unit_price, status, last_update)
SELECT @order3, ci.product_ID, ci.quantity, ci.unit_price, b'1', NOW()
FROM tbd_cart_items ci
WHERE ci.cart_ID = @cart3;

-- 2D. Dirección alterna
INSERT INTO tb_user_addresses (user_ID, label, is_default, status)
VALUES (@user3, 'Casa Papas', 0, b'1');

SET @addr3 = LAST_INSERT_ID();

INSERT INTO tbd_address_components (address_ID, value, component_type, status)
VALUES (@addr3, 'Privada Las Flores 88', 'street', b'1');

-- 3. Tarjeta digital Spin (16 dígitos) y pago por el costo total
INSERT IGNORE INTO tbc_payment_method_types (code, description, status, last_update)
VALUES ('SPIN', 'Tarjeta digital Spin', b'1', NOW());

SELECT ID INTO @pm_type_spin FROM tbc_payment_method_types WHERE code = 'SPIN' LIMIT 1;

INSERT IGNORE INTO tbd_user_payment_methods (
    user_ID, payment_method_type_ID, provider, provider_method_ref, label, last_four, is_default, status
)
VALUES (@user3, @pm_type_spin, 'Paypal', '4027123456789012', 'Spin Digital', '9012', 0, b'1');

SELECT ID INTO @upm3
FROM tbd_user_payment_methods
WHERE provider = 'Paypal' AND provider_method_ref = '4027123456789012'
LIMIT 1;

SET @total3 = COALESCE(@sub3, 3000.00) + 100.00;

INSERT INTO tb_payments (user_ID, payment_method_type_ID, user_payment_method_ID, total_amount, currency, status, last_update)
VALUES (@user3, @pm_type_spin, @upm3, @total3, 'MXN', b'1', NOW());

SET @pay3 = LAST_INSERT_ID();

-- Registro puente en tbd_payments (desbloquea la FK de tb_cancellations)
INSERT INTO tbd_payments (
    payment_ID, order_ID, payment_method_type_ID, user_payment_method_ID, amount_paid, currency, payment_status, status
)
VALUES (@pay3, @order3, @pm_type_spin, @upm3, @total3, 'MXN', 'Completed', b'1');

INSERT INTO tb_payment_transaction (
    payment_ID, transaction_type, amount, currency, gateway_transaction_id, gateway_response, operation_status, status, last_update
)
VALUES (@pay3, 'Charge', @total3, 'MXN', 'TXN_CASO3_001', 'CASH + SPIN REGISTERED', 'Completed', b'1', NOW());

-- 4. Marcar orden como atendida (apuntando a @buyer_order3)
UPDATE tb_buyer_orders
SET fulfillment_status = 'Accepted'
WHERE ID = @buyer_order3;

-- 5. Cancelación parcial de 1 producto en tb_cancellations / tbd_cancellation_items y ajuste de subtotal
SELECT MAX(ID) INTO @pay3 FROM tb_payments;
SELECT user_ID INTO @user3 FROM tb_payments WHERE ID = @pay3;
SELECT MAX(ID) INTO @canc3 FROM tb_cancellations;
SELECT MAX(ID) INTO @order3 FROM tb_orders;
SELECT MAX(ID) INTO @buyer_order3 FROM tb_buyer_orders;

SELECT product_ID, quantity, unit_price INTO @prod3_cancel, @qty3_cancel, @price3_cancel
FROM tbd_order_items
WHERE order_ID = @order3
LIMIT 1;

SET @monto_cancel3 = COALESCE(@qty3_cancel * @price3_cancel, 500.00);

-- 2. Insertar en tb_order_cancellations (tabla padre que exige tbd_cancellation_items)
INSERT INTO tb_order_cancellations (payment_ID, requested_by_user_ID, reason, cancellation_status, status, last_update)
VALUES (@pay3, @user3, 'Cancelacion parcial de 1 producto', 'Approved', b'1', NOW());

SET @order_canc3 = LAST_INSERT_ID();

-- 3. Insertar detalle en tbd_cancellation_items apuntando a @order_canc3
INSERT INTO tbd_cancellation_items (cancellation_ID, product_ID, quantity, cancellation_reason, status, last_update)
VALUES (@order_canc3, @prod3_cancel, COALESCE(@qty3_cancel, 1), 'Cancelacion de articulo', b'1', NOW());

-- 4. Ajustar el subtotal de la orden en tb_buyer_orders
UPDATE tb_buyer_orders
SET subtotal = GREATEST(0, subtotal - @monto_cancel3)
WHERE ID = @buyer_order3;

-- 5. Registrar reembolso parcial en tb_refunds (apuntando a @canc3 de tb_cancellations)
INSERT INTO tb_refunds (
    payment_ID, cancellation_ID, return_ID, refund_amount, refund_reason, refund_status, gateway_refund_id, status, last_update
)
VALUES (@pay3, @canc3, NULL, @monto_cancel3, 'Rembolso parcial por producto cancelado', 'Completed', 'REF_CASO3_001', b'1', NOW());

-- 6. Actualizar estados finales de envío ('Sent') y entrega ('Delivered')
UPDATE tb_buyer_orders
SET fulfillment_status = 'Sent'
WHERE ID = @buyer_order3;

UPDATE tb_buyer_orders
SET fulfillment_status = 'Delivered'
WHERE ID = @buyer_order3;

-- 6. Rembolso parcial en tb_refunds, envío ('Sent') y entrega en casa ('Delivered')
-- UBICACIÓN CORREGIDA: Se agrega last_update y NOW()
INSERT INTO tb_refunds (
    payment_ID, cancellation_ID, return_ID, refund_amount, refund_reason, refund_status, gateway_refund_id, status, last_update
)
VALUES (@pay3, @canc3, NULL, @monto_cancel3, 'Rembolso parcial por producto cancelado', 'Completed', 'REF_CASO3_001', b'1', NOW());

UPDATE tb_buyer_orders
SET fulfillment_status = 'Sent'
WHERE ID = @buyer_order3;

UPDATE tb_buyer_orders
SET fulfillment_status = 'Delivered'
WHERE ID = @buyer_order3;