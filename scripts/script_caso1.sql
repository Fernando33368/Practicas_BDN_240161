-- Caso de Prueba 1: "Compra exitosa sin modificaciones"
USE db_test_240161;

-- 1. Registrar nuevo usuario (se usa un correo y nick nuevos para evitar error de duplicado)
INSERT INTO tb_users (email, nick, password, status)
VALUES ('angelN.21@gmail.com', 'Angel Nazul 2', 'password1234567891023344556', b'1');

SET @user_id = LAST_INSERT_ID();

-- 2. Consultar 10,000 productos disponibles y seleccionar 5
SELECT * FROM tb_products WHERE status = b'1' LIMIT 10000;

-- 3. Crear carrito y agregar 5 productos con distintas cantidades
INSERT INTO tb_carts (user_ID, status) VALUES (@user_id, b'1');

SET @cart_id = LAST_INSERT_ID();

INSERT INTO tbd_cart_items (cart_ID, product_ID, quantity, last_update)
VALUES 
    (@cart_id, 1, 1, NOW()),
    (@cart_id, 2, 2, NOW()),
    (@cart_id, 3, 3, NOW()),
    (@cart_id, 4, 1, NOW()),
    (@cart_id, 5, 4, NOW());
    
-- 4. Generar orden en tb_buyer_orders y guardar su ID
INSERT INTO tb_buyer_orders (seller_ID, subtotal, fulfillment_status, status)
VALUES (1, 1500.00, 'Pending', b'1');

SET @order_id = LAST_INSERT_ID();

-- 5. Registrar domicilio y asegurar tipo de pago en catálogo
INSERT INTO tb_user_addresses (user_ID, label, is_default, status) 
VALUES (@user_id, 'Casa', 1, b'1');

INSERT IGNORE INTO tbc_payment_method_types (code, description, status, last_update)
VALUES ('DEBIT_CARD', 'Tarjeta de Débito 16 dígitos', b'1', NOW());

SELECT ID INTO @payment_type_id FROM tbc_payment_method_types WHERE code = 'DEBIT_CARD' LIMIT 1;

-- 6. Pago único (se omite UPDATE de role_name porque la columna no existe en tb_users)
INSERT INTO tb_payments (user_ID, payment_method_type_ID, user_payment_method_ID, total_amount, currency, status, last_update)
VALUES (@user_id, @payment_type_id, NULL, 1500.00, 'MXN', b'1', NOW());

-- 7. Atención de la orden y entrega en casa
UPDATE tb_buyer_orders SET fulfillment_status = 'Accepted' WHERE ID = @order_id;
UPDATE tb_buyer_orders SET fulfillment_status = 'Sent' WHERE ID = @order_id;
UPDATE tb_buyer_orders SET fulfillment_status = 'Delivered' WHERE ID = @order_id;