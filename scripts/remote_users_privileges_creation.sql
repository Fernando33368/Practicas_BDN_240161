/* ============================================================
   CREACIÓN DE USUARIOS REMOTOS
   ============================================================ */


CREATE USER IF NOT EXISTS 'fernando.miguel'@'%' IDENTIFIED BY '240161';
CREATE USER IF NOT EXISTS 'nazul.gutierrez'@'%' IDENTIFIED BY '240162';
CREATE USER IF NOT EXISTS 'carlos.cabrera'@'%' IDENTIFIED BY '240201';
CREATE USER IF NOT EXISTS 'rodolfo.hernandez'@'%' IDENTIFIED BY '240836';
CREATE USER IF NOT EXISTS 'app.web'@'%' IDENTIFIED BY 'Web123';
CREATE USER IF NOT EXISTS 'app.movil'@'%' IDENTIFIED BY 'Mobile890';



/* ============================================================
   ASIGNACIÓN DE PRIVILEGIOS DIRECTOS
   ============================================================ */

/* Usuario administrador */
GRANT ALL PRIVILEGES ON *.* TO 'fernando.miguel'@'%';


/* Privilegios CRUD sobre db_test*/
GRANT SELECT, INSERT, UPDATE, DELETE ON db_test_240161.* TO 'nazul.gutierrez'@'%';


/* ============================================================
   CREACIÓN DE ROLES PARA EL SISTEMA E-COMMERCE
   ============================================================ */

CREATE ROLE IF NOT EXISTS 'superadmin'@'%';
CREATE ROLE IF NOT EXISTS 'admin'@'%';
CREATE ROLE IF NOT EXISTS 'seller'@'%';
CREATE ROLE IF NOT EXISTS 'buyer'@'%';
CREATE ROLE IF NOT EXISTS 'support'@'%';
CREATE ROLE IF NOT EXISTS 'common'@'%';
CREATE ROLE IF NOT EXISTS 'user_not_registered'@'%';


/* ============================================================
   ASIGNACIÓN DE PRIVILEGIOS A LOS ROLES
   ============================================================ */

/* SUPERADMIN */

GRANT ALL PRIVILEGES ON *.* TO 'superadmin';    

/* ADMIN */
GRANT ALL PRIVILEGES ON db_test_240161.* TO 'admin';


/* SUPPORT */
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tb_users TO 'support';
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tb_products TO 'support';
GRANT EXECUTE ON PROCEDURE db_test_240161.sp_soft_delete_user TO 'support'@'%';


/* SELLER */
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tb_products TO 'seller';
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tb_products TO 'seller';

/*Buyer*/
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tb_carts TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tbd_carts_items TO 'buyer';
GRANT SELECT, INSERT ON db_test_240161.tb_buyer_orders TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON db_test_240161.tbd_users_wishlist_products TO 'buyer';


/* ============================================================
   ASIGNACIÓN DE ROLES A LOS USUARIOS
   ============================================================ */


-- Este deben ser ustedes
GRANT 'superadmin' TO 'fernando.miguel'@'%';
-- Este debe ser el Prof. Marco
GRANT 'admin' TO 'marco.ramirez'@'%';
-- IZQUIERDA
GRANT 'support' TO 'carlos.cabrera'@'%';
-- DERECHA
GRANT 'seller' TO 'carlos.cabrera'@'%';
GRANT 'seller' TO 'rodolfo.hernandez'@'%';

GRANT 'user_not_registered' TO ''@'%';
GRANT 'user_not_registered', 'common_user', 'buyer' TO 'AppWeb'@'%';
GRANT 'user_not_registered', 'common_user', 'buyer' TO 'AppMobile'@'%';


/* ============================================================
   ESTABLECER ROLES PREDETERMINADOS
   ============================================================ */



SET DEFAULT ROLE 'admin' TO 'fernando.miguel'@'%';

SET DEFAULT ROLE 'support' TO 'carlos.cabrera'@'%';

SET DEFAULT ROLE 'seller' TO 'carlos.cabrera'@'%';
SET DEFAULT ROLE 'seller' TO 'rodolfo.hernandez'@'%';



/* ============================================================
   VERIFICACIÓN
   ============================================================ */

/* Usuarios */
SELECT User, Host FROM mysql.user ORDER BY User;


/* Roles creados */
SELECT User, Host FROM mysql.user WHERE Host = '%' AND account_locked = 'Y';


/* Usuarios y roles asignados */
SELECT
   TO_USER AS usuario,
   TO_HOST AS host,
   FROM_USER AS rol,
   FROM_HOST AS rol_host 
   FROM mysql.role_edges ORDER BY TO_USER, FROM_USER;


/* Mensaje final */
SELECT 'Los usuarios, roles y privilegios han sido creados correctamente' AS mensaje;