/* ============================================================
   CREACIÓN DE USUARIOS REMOTOS
   ============================================================ */

CREATE USER IF NOT EXISTS 'fernando.miguel'@'%' IDENTIFIED BY '240161';
CREATE USER IF NOT EXISTS 'nazul.gutierrez'@'%' IDENTIFIED BY '240162';
CREATE USER IF NOT EXISTS 'carlos.cabrera'@'%' IDENTIFIED BY '240201';


/* ============================================================
   ASIGNACIÓN DE PRIVILEGIOS DIRECTOS
   ============================================================ */

/*
IMPORTANTE:
Este privilegio solamente debe asignarse al usuario administrador.
*/

GRANT ALL PRIVILEGES ON *.* TO 'fernando.miguel'@'%';

/*
Asignar privilegios CRUD sobre la base db_test.
*/

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test.*
TO 'carlos.cabrera'@'192.168.1.64';


/* ============================================================
   CREACIÓN DE ROLES PARA EL SISTEMA E-COMMERCE
   ============================================================ */

CREATE ROLE IF NOT EXISTS 'superadmin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* ============================================================
   ASIGNACIÓN DE PRIVILEGIOS A LOS ROLES
   ============================================================ */

/* SUPERADMIN */
GRANT ALL PRIVILEGES
ON *.*
TO 'superadmin';    

/* ADMIN */
GRANT ALL PRIVILEGES
ON db_test.*
TO 'admin';


/* SUPPORT */
GRANT SELECT, INSERT, UPDATE ON db_test.tb_users TO 'support';
GRANT SELECT, INSERT, UPDATE ON db_test.tb_products TO 'support';
/* SELLER */
GRANT SELECT, INSERT, UPDATE ON db_test.tb_products TO 'seller';

/* ============================================================
   ASIGNACIÓN DE ROLES A LOS USUARIOS
   ============================================================ */

-- Este deben ser ustedes
GRANT 'superadmin' TO 'fernando.miguel'@'%';
-- Este debe ser el Prof. Marco
GRANT 'admin' TO 'marco.ramirez'@'%';
-- IZQUIERDA
GRANT 'support' TO 'carlos.cabrera'@'192.168.1.64';
-- DERECHA
GRANT 'seller' TO 'carlos.cabrera'@'192.168.1.64';
GRANT 'seller' TO 'carlos.cabrera'@'192.168.1.64';

/* ============================================================
   ESTABLECER ROLES PREDETERMINADOS
   ============================================================ */

/*
Esto permite que el rol se active automáticamente cuando
el usuario inicia sesión.
*/

SET DEFAULT ROLE 'admin'
TO 'fernando.miguel'@'%';

SET DEFAULT ROLE 'support'
TO 'carlos.cabrera'@'192.168.1.64';

SET DEFAULT ROLE 'seller'
TO 'carlos.cabrera'@'192.168.1.64';
SET DEFAULT ROLE 'seller'
TO 'carlos.cabrera'@'192.168.1.64';


/* ============================================================
   VERIFICACIÓN
   ============================================================ */

/* Mostrar usuarios remotos creados */
SELECT "Los usuarios y privilegios han sido creados correctamente" AS mensaje;