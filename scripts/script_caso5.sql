-- Caso de Prueba 5: "Compra fallida por falta de inventario"
USE db_test_240161;

SELECT ID INTO @user5 FROM tb_users WHERE status = b'1' ORDER BY ID DESC LIMIT 1;

-- Asegurar 1 producto con stock insuficiente (ej. current_stock = 1)
UPDATE tb_products
SET current_stock = 1
WHERE ID = 1;

SELECT user_ID INTO @seller5 FROM tbd_products_users_providers WHERE product_ID = 1 LIMIT 1;

-- 1. Carrito con 1 producto y cantidad entre 1 y 5 superior al stock (ej. 4 unidades)
INSERT INTO tb_carts (user_ID, status)
VALUES (@user5, b'1')
ON DUPLICATE KEY UPDATE status = b'1';

SELECT ID INTO @cart5 FROM tb_carts WHERE user_ID = @user5 LIMIT 1;

DELETE FROM tbd_cart_items WHERE cart_ID = @cart5;

INSERT INTO tbd_cart_items (cart_ID, product_ID, quantity, unit_price, status, last_update)
SELECT @cart5, ID, 4, current_price, b'1', NOW()
FROM tb_products
WHERE ID = 1;

-- 2. Crear orden, registrar domicilio hogar y aplicar cupón de regalo
SELECT current_price * 4 INTO @sub5 FROM tb_products WHERE ID = 1;

INSERT INTO tb_buyer_orders (seller_ID, subtotal, shipping_cost, fulfillment_status, status)
VALUES (COALESCE(@seller5, 1), COALESCE(@sub5, 400.00), 90.00, 'Pending', b'1');

SET @buyer_order5 = LAST_INSERT_ID();

INSERT INTO tb_orders (user_ID, order_number, total_amount, order_status, status, last_update)
VALUES (@user5, CONCAT('ORD-05', UNIX_TIMESTAMP()), COALESCE(@sub5, 550.00), 'Pending', b'1', NOW());

SET @order5 = LAST_INSERT_ID();

INSERT INTO tbd_order_items (order_ID, product_ID, quantity, unit_price, status, last_update)
SELECT @order5, ci.product_ID, ci.quantity, ci.unit_price, b'1', NOW()
FROM tbd_cart_items ci
WHERE ci.cart_ID = @cart5;

INSERT INTO tb_user_addresses (user_ID, label, is_default, status)
VALUES (@user5, 'Hogar', 1, b'1');

SET @addr5 = LAST_INSERT_ID();

INSERT INTO tbd_address_components (address_ID, value, component_type, status)
VALUES (@addr5, 'Av. Juarez 210', 'street', b'1');

INSERT IGNORE INTO tbc_payment_method_types (code, description, status)
VALUES ('GIFT_COUPON', 'Cupon de regalo', b'1');

SELECT ID INTO @pm_type_coupon FROM tbc_payment_method_types WHERE code = 'GIFT_COUPON' LIMIT 1;

INSERT IGNORE INTO tbd_user_payment_methods (
    user_ID, payment_method_type_ID, provider, provider_method_ref, label, last_four, is_default, status
)
VALUES (@user5, @pm_type_coupon, 'PromoEngine', 'CUPON-REGALO-100', 'Cupon Regalo', '0100', 0, b'1');

SET @upm5 = LAST_INSERT_ID();

INSERT INTO tb_payments (user_ID, payment_method_type_ID, user_payment_method_ID, total_amount, currency, status, last_update)
VALUES (@user5, @pm_type_coupon, @upm5, 100.00, 'MXN', b'1', NOW());

SET @pay5 = LAST_INSERT_ID();

-- 3. Fallo por falta de inventario -> marcar orden como cancelada / no atendida
UPDATE tb_buyer_orders
SET fulfillment_status = 'Canceled'
WHERE ID = @order5;

INSERT INTO tb_payment_transaction (
    payment_ID, transaction_type, amount, currency, gateway_transaction_id, gateway_response, operation_status, status, last_update
)
VALUES (@pay5, 'Void', 100.00, 'MXN', 'TXN_CASO5_VOID', 'CANCELED: Falta de inventario', 'Cancelled', b'1', NOW());

-- 4. Reasignar / liberar cupón de regalo para que quede disponible
UPDATE tbd_user_payment_methods
SET user_ID = @user5, status = b'1'
WHERE ID = @upm5;