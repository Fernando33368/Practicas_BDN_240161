USE db_test_240161;

SELECT ID INTO @user4 FROM tb_users WHERE status = b'1' ORDER BY ID DESC LIMIT 1;

-- Tomar un proveedor con al menos 3 productos
SELECT user_ID INTO @seller4
FROM tbd_products_users_providers
WHERE status = b'1'
GROUP BY user_ID
HAVING COUNT(*) >= 3
LIMIT 1;

-- 1. Carrito con 3 productos del mismo proveedor (cantidad entre 1 y 3)
INSERT INTO tb_carts (user_ID, status)
VALUES (@user4, b'1')
ON DUPLICATE KEY UPDATE status = b'1';

SELECT ID INTO @cart4 FROM tb_carts WHERE user_ID = @user4 LIMIT 1;

DELETE FROM tbd_cart_items WHERE cart_ID = @cart4;

INSERT INTO tbd_cart_items (cart_ID, product_ID, quantity, unit_price, status)
SELECT @cart4, p.ID, FLOOR(1 + (RAND() * 3)), p.current_price, b'1'
FROM tb_products p
JOIN tbd_products_users_providers pup ON pup.product_ID = p.ID
WHERE pup.user_ID = @seller4 AND p.status = b'1'
LIMIT 3;

-- 2. Orden del mismo proveedor y domicilio del hogar
SELECT SUM(quantity * unit_price) INTO @sub4
FROM tbd_cart_items
WHERE cart_ID = @cart4;

INSERT INTO tb_buyer_orders (seller_ID, subtotal, shipping_cost, fulfillment_status, status)
VALUES (COALESCE(@seller4, 1), COALESCE(@sub4, 1800.00), 80.00, 'Pending', b'1');

SET @order4 = LAST_INSERT_ID();

INSERT INTO tbd_order_items (order_ID, product_ID, quantity, unit_price, status)
SELECT @order4, ci.product_ID, ci.quantity, ci.unit_price, b'1'
FROM tbd_cart_items ci
WHERE ci.cart_ID = @cart4;

INSERT INTO tb_user_addresses (user_ID, label, is_default, status)
VALUES (@user4, 'Hogar', 1, b'1');

SET @addr4 = LAST_INSERT_ID();

INSERT INTO tbd_address_components (address_ID, value, component_type, status)
VALUES (@addr4, 'Calle Hidalgo 45', 'street', b'1');

-- 3. Método SPEI (16 dígitos) y pago por el total
INSERT IGNORE INTO tbc_payment_method_types (code, description, status)
VALUES ('SPEI', 'Transferencia SPEI', b'1');

SELECT ID INTO @pm_type_spei FROM tbc_payment_method_types WHERE code = 'SPEI' LIMIT 1;

INSERT INTO tbd_user_payment_methods (
    user_ID, payment_method_type_ID, provider, provider_method_ref, label, last_four, is_default, status
)
VALUES (@user4, @pm_type_spei, 'STP', '6461801234567890', 'Cuenta SPEI', '7890', 0, b'1');

SET @upm4 = LAST_INSERT_ID();

SET @total4 = COALESCE(@sub4, 1800.00) + 80.00;

INSERT INTO tb_payments (user_ID, payment_method_type_ID, user_payment_method_ID, total_amount, currency, status, last_update)
VALUES (@user4, @pm_type_spei, @upm4, @total4, 'MXN', b'1', NOW());

SET @pay4 = LAST_INSERT_ID();

INSERT INTO tb_payment_transaction (
    payment_ID, transaction_type, amount, currency, gateway_transaction_id, gateway_response, operation_status, status, last_update
)
VALUES (@pay4, 'Charge', @total4, 'MXN', 'TXN_CASO4_001', 'SPEI + CASH REGISTERED', 'Completed', b'1', NOW());

-- 4. Atención, envío y recolección en punto de recolección (al no haber quien recibiera en hogar)
UPDATE tb_buyer_orders
SET fulfillment_status = 'Accepted'
WHERE ID = @order4;

INSERT INTO tb_shipments (payment_ID, shipping_company, tracking_number, shipping_cost, shipping_status, status, last_update)
VALUES (@pay4, 'E-commerce Logistics', 'TRK_CASO4_PICKUP', 80.00, 'In_Transit', b'1', NOW());

UPDATE tb_buyer_orders
SET fulfillment_status = 'Sent'
WHERE ID = @order4;

UPDATE tb_shipments
SET shipping_status = 'Delivered', actual_delivery_date = NOW()
WHERE payment_ID = @pay4;

UPDATE tb_buyer_orders
SET fulfillment_status = 'Delivered'
WHERE ID = @order4;