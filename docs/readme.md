# Práctica 03: Manipulación de Datos, Relaciones, Procedimientos, Funciones y Eventos en Conexiones Remotas
 
## 1. Modelo relacional
 
El respaldo contiene **26 tablas** con **39 llaves foráneas** y llaves primarias, únicas y restricciones. Todas usan InnoDB y `utf8mb4`.
 
- **25 tablas operativas** auditadas con triggers:
  - `tb_` (14): `tb_users`, `tb_people`, `tb_user_addresses`, `tb_products`, `tb_carts`, `tb_orders`, `tb_buyer_orders`, `tb_payments`, `tb_payment_transaction`, `tb_shipments`, `tb_cancellations`, `tb_order_cancellations`, `tb_returns`, `tb_refunds`.
  - `tbc_` (2): `tbc_categories`, `tbc_payment_method_types`.
  - `tbd_` (9): `tbd_address_components`, `tbd_cart_items`, `tbd_order_items`, `tbd_products_categories`, `tbd_products_users_providers`, `tbd_users_wishlist_products`, `tbd_user_payment_methods`, `tbd_cancellation_items`, `tbd_return_items`.
- **1 tabla de bitácora:** `tb_logs`.
- Características: borrado lógico con la columna `status`, jerarquía de categorías (`tbc_categories.sup_id_category`), jerarquía de componentes de dirección y columna generada `tbd_order_items.subtotal`.
## 2. Triggers y auditoría
 
- **75 triggers** (`AFTER INSERT`, `AFTER UPDATE`, `AFTER DELETE` × 25 tablas operativas).
- Cada trigger escribe en `tb_logs`: tabla afectada, operación (`Create`/`Read`/`Update`/`Delete`), usuario de conexión (`db_user`), fecha, descripción del cambio y estado.
- `tb_logs` acumula **22,030 registros** (del 7 al 10 de noviembre de 2026):
| Tabla auditada | Registros en `tb_logs` |
|---|---|
| `tb_users` | 7,501 |
| `tb_people` | 7,501 |
| `tbd_products_categories` | 7,000 |
| `tbc_categories` | 19 |
| `tb_products` | 9 |
 
- Por operación: 22,024 `Create`, 4 `Update` y 2 `Delete`.
- Por usuario: `root@localhost` (22,025 registros) y `root` (5).

## 3. Vistas SQL
 
- **27 vistas:** 26 de trazabilidad (`vw_trazabilidad_*`) y **`vw_total_products_by_category`**.
- `vw_total_products_by_category` muestra ruta y nivel de la categoría, total de productos, activos, inactivos y sin categoría.
- **5 vistas de trazabilidad** tienen consulta real (categorías, categorización de productos, producto–proveedor, productos y usuarios): cruzan cada tabla con la bitácora e incluyen usuario de BD, roles, detalle, fecha y estado de la operación.
- Las otras **21** solo contienen una definición de relleno (`SELECT 1 …`) y no devuelven datos útiles.

## 4. Usuarios, roles y privilegios
 
- Las cuentas, roles y privilegios del servidor no se incluyen en el respaldo (viven en el esquema `mysql`).
- Las vistas de trazabilidad consultan `mysql.role_edges` para mostrar el rol de quien hizo cada operación; si no tiene, aparece "Sin rol asignado".
- Triggers y vistas se crearon con `DEFINER=root@localhost`.
- La bitácora solo registra al usuario `root`: **no aparecen conexiones remotas de otros usuarios**.
 
## 5. Usuarios y personas registrados
 
Creados el 7 de noviembre de 2026 entre las 18:35:29 y las 18:36:32: **7,501 usuarios** en `tb_users` y **7,501 personas** en `tb_people`, todos registrados en `tb_logs`.
 
| Concepto | Resultado |
|---|---|
| Estado | 6,004 activos / 1,497 inactivos (20 %) |
| Países | 10, con 747 a 756 usuarios cada uno (México, Colombia y Reino Unido 756; Alemania 750; Estados Unidos 748; España, Argentina, Canadá, Brasil y Francia 747) |
| Edades | 19 a 35 años |
| Género (`tb_people`) | 5,611 Masculino / 1,890 Femenino |
 
- En `tb_users`, la columna `genero` tiene 5,610 Masculino y 1,890 Femenino (1 sin dato); `gender` casi no se usa (1 registro).

## 6. Productos y categorías
 
- **7,002 productos** en `tb_products`, **todos activos** (ninguno descontinuado).
- SKU únicos, sin duplicados (formato `PROD-0000001`); precios de 10.00 a 999.85 y existencias de 0 a 500.
- Los IDs llegan hasta 10241: hay huecos por productos eliminados (el producto de prueba 10240).
- Los 7,000 productos `PROD-` se cargaron el 7-nov-2026 (de 14:00 a 18:57) y los 2 restantes son de prueba (`TEST-LOG-01` y `TEST-240162`).
- **19 categorías** (4 principales y 15 subcategorías), creadas el 10-nov-2026:
| Categoría principal | Subcategorías |
|---|---|
| Electrónica y Computación | Laptops, Monitores, Teclados, Auriculares, Cargadores, Cámaras |
| Moda y Accesorios | Camisetas, Zapatillas, Mochilas, Relojes |
| Hogar y Muebles | Mesas, Sillas, Lámparas, Botellas |
| Herramientas y Ferretería | Taladros |
 
- **7,000 relaciones** en `tbd_products_categories`: las 15 subcategorías tienen entre 437 y 507 productos cada una.
- 7,000 productos tienen categoría asignada y los 2 de prueba no.

## 7. Tablas vacías
 
Solo 6 tablas traen datos (`tb_users`, `tb_people`, `tb_products`, `tb_logs`, `tbc_categories` y `tbd_products_categories`). Las otras 20 (carritos, órdenes, pagos, envíos, cancelaciones, devoluciones, reembolsos, direcciones, etc.) se respaldaron sin registros.
 
## 8. Respaldo y restauración
 
- `db_test_240161.sql` incluye estructura, datos, triggers y vistas, y usa `CREATE DATABASE IF NOT EXISTS` y `DROP TABLE IF EXISTS` (restaurar sobrescribe las tablas existentes).
- Restaurar:

```bash
mysql -u root -p < db_test_240161.sql
```

- Si el usuario `root@localhost` no existe en el servidor destino, hay que ajustar el `DEFINER` de triggers y vistas.
- Las vistas de trazabilidad requieren permisos de lectura sobre `mysql.role_edges`.