# Documentacion de la Practica 03: Manipulacion de Datos, Relaciones, Procedimientos, Funciones y Eventos en Conexiones Remotas.

# Documentación de la base de datos `db_test_240161`
 
Base de datos **`db_test_240161`** (MySQL 8.3.0, Windows, conexión local 127.0.0.1). Resumen basado en el respaldo `respaldo_db_test_240161.sql`
 
## 1. Modelo relacional
 
El respaldo contiene **26 tablas** con **39 llaves foráneas** y llaves primarias, únicas y restricciones. Todas usan InnoDB y `utf8mb4`.
 
- **25 tablas operativas** auditadas con triggers:
  - `tb_` (14): `tb_users`, `tb_people`, `tb_user_addresses`, `tb_products`, `tb_carts`, `tb_orders`, `tb_buyer_orders`, `tb_payments`, `tb_payment_transaction`, `tb_shipments`, `tb_cancellations`, `tb_order_cancellations`, `tb_returns`, `tb_refunds`.
  - `tbc_` (2): `tbc_categories`, `tbc_payment_method_types`.
  - `tbd_` (9): `tbd_address_components`, `tbd_cart_items`, `tbd_order_items`, `tbd_products_categories`, `tbd_products_users_providers`, `tbd_users_wishlist_products`, `tbd_user_payment_methods`, `tbd_cancellation_items`, `tbd_return_items`.
- **1 tabla de bitácora:** `tb_logs`.
- Características destacadas: borrado lógico con la columna `status`, jerarquía de categorías (`tbc_categories.sup_id_category`), jerarquía de componentes de dirección y columna generada `tbd_order_items.subtotal`.
## 2. Triggers y auditoría
 
- **75 triggers** (`AFTER INSERT`, `AFTER UPDATE`, `AFTER DELETE` × 25 tablas operativas).
- Cada trigger escribe en `tb_logs`: tabla afectada, operación (`Create`/`Update`/`Delete`), usuario de conexión (`db_user`), fecha, descripción del cambio y estado.
- `tb_logs` acumula **7,510 registros** (7-nov-2026, de 18:35 a 18:57): 7,501 de `tb_users` y 9 de `tb_products`.
- Por operación: 7,504 `Create`, 4 `Update` y 2 `Delete`. Todas se hicieron con el usuario `root` (`root@localhost` en 7,505 registros y `root` en 5).
## 3. Vistas SQL
 
- **27 vistas:** 26 de trazabilidad (`vw_trazabilidad_*`) y **`vw_total_products_by_category`**.
- `vw_total_products_by_category` muestra ruta y nivel de la categoría, total de productos, activos, inactivos y sin categoría.
- Solo **5 vistas de trazabilidad** tienen consulta real (categorías, categorización de productos, producto–proveedor, productos y usuarios): cruzan la bitácora con el usuario de BD, sus roles, el detalle y la fecha.
- Las otras **21** solo contienen una definición de relleno (`SELECT 1 …`) y no devuelven datos útiles.
## 4. Usuarios, roles y privilegios
 
- Las cuentas, roles y privilegios del servidor no vienen en el respaldo (viven en el esquema `mysql`).
- Las vistas de trazabilidad consultan `mysql.role_edges` para mostrar el rol de quien hizo cada operación; si no tiene, aparece "Sin rol asignado".
- Triggers y vistas se crearon con `DEFINER=root@localhost`.
- En la bitácora solo aparece `root`, por lo que no hay conexiones remotas registradas.

 
## 5. Productos
 
- **7,002 productos** en `tb_products`, **todos activos** (ninguno descontinuado).
- SKU únicos, sin duplicados (formato `PROD-0000001`); precios de 10.00 a 999.85 y existencias de 0 a 500.
- Los IDs llegan hasta 10241: hay huecos por productos eliminados (por ejemplo el 10240, un producto de prueba).
- Categorías: `tbc_categories` y `tbd_products_categories` están vacías, así que ningún producto tiene categoría.
- Solo se auditaron 9 operaciones de `tb_products`, todas de pruebas (SKU `TEST-240161` y `TEST-240162`).

## 6. Respaldo
 
- `respaldo_db_test_240161.sql` (4.5 MB) incluye estructura, datos de `tb_users`, `tb_products` y `tb_logs` (el resto de las tablas va vacío), triggers y vistas.
- Generado con mysqldump 10.13 (MySQL 8.0.42, Win64) el 2026-11-07 19:03:20.
## 7. Puntos de atención
 
- `tb_cancellations.payment_ID` apunta a `tbd_payments`, una tabla que no existe en el respaldo.
- `tb_cancellations` y `tb_order_cancellations` tienen la misma estructura (duplicidad).
- `tb_users` tiene las columnas duplicadas `gender` y `genero`.
- 16 tablas tienen `last_update` NOT NULL sin valor por defecto, lo que puede dar error en un INSERT en modo estricto.
- Las contraseñas son un hash hexadecimal de 64 caracteres (aspecto de SHA-256); conviene revisar que lleve sal.