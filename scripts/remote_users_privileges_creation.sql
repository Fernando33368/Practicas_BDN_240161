/* ============================================================
   CREACIÓN DE USUARIOS REMOTOS
   ============================================================ */

CREATE USER IF NOT EXISTS 'fernando.miguel'@'%'
IDENTIFIED BY '240161';

CREATE USER IF NOT EXISTS 'nazul.gutierrez'@'%'
IDENTIFIED BY '240162';

CREATE USER IF NOT EXISTS 'carlos.cabrera'@'%'
IDENTIFIED BY '240201';


/* ============================================================
   ASIGNACIÓN DE PRIVILEGIOS DIRECTOS
   ============================================================ */

/* Usuario administrador */
GRANT ALL PRIVILEGES
ON *.*
TO 'fernando.miguel'@'%';


/* Privilegios CRUD sobre db_test para Carlos */
GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test.*
TO 'carlos.cabrera'@'%';


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
GRANT ALL PRIVILEGES
ON *.*
TO 'superadmin'@'%';


/* ADMIN */
GRANT ALL PRIVILEGES
ON db_test.*
TO 'admin'@'%';


/* SUPPORT */
GRANT SELECT, INSERT, UPDATE
ON db_test.tb_users
TO 'support'@'%';

GRANT SELECT, INSERT, UPDATE
ON db_test.tb_products
TO 'support'@'%';


/* SELLER */
GRANT SELECT, INSERT, UPDATE
ON db_test.tb_products
TO 'seller'@'%';


/* ============================================================
   ASIGNACIÓN DE ROLES A LOS USUARIOS
   ============================================================ */

/* Fernando = SUPERADMIN */
GRANT 'superadmin'@'%'
TO 'fernando.miguel'@'%';


/* Carlos = SUPPORT + SELLER */
GRANT 'support'@'%'
TO 'carlos.cabrera'@'%';

GRANT 'seller'@'%'
TO 'carlos.cabrera'@'%';


/* ============================================================
   ESTABLECER ROLES PREDETERMINADOS
   ============================================================ */

SET DEFAULT ROLE 'superadmin'@'%'
TO 'fernando.miguel'@'%';

SET DEFAULT ROLE
    'support'@'%',
    'seller'@'%'
TO 'carlos.cabrera'@'%';


/* ============================================================
   VERIFICACIÓN
   ============================================================ */

/* Usuarios */
SELECT User, Host
FROM mysql.user
ORDER BY User;


/* Roles creados */
SELECT User, Host
FROM mysql.user
WHERE Host = '%'
  AND account_locked = 'Y';


/* Usuarios y roles asignados */
SELECT
    TO_USER AS usuario,
    TO_HOST AS host,
    FROM_USER AS rol,
    FROM_HOST AS rol_host
FROM mysql.role_edges
ORDER BY TO_USER, FROM_USER;


/* Mensaje final */
SELECT
    'Los usuarios, roles y privilegios han sido creados correctamente'
    AS mensaje;