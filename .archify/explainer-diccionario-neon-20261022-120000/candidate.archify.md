# Diccionario de datos - db_testa_240161

El respaldo define **16 tablas y 6 vistas** en MySQL. Esta pagina documenta el esqueema declarado, sus restaricciones y el proposito inferido de cada campo; no reproduce filas de datos.

- El modelo cubre cuentas, catalogo, direcciones, pagos, listas de deseos y auditoria.
- Las claves y nulabilidad se transcriben del DDL del respaldo del 22 de octubre de 2026.
- Las vistas calculan columnas; sus tipos dependen de las expresiones SQL y no estan declarados como columnas fisicas.

@answer scope="Esqueema MySQL del respaldo - DDL y vistas - sin filas de datos"
@meta locale=es style=product

## Resumen del modelo {#resumen}

@facts id=metricas-esqueema
| Elemento | Cantidad |
| Tablas fisicas | 16 |
| Vistas | 6 |
| Motor | InnoDB |
| Juego de caracteres | utf8mb4 |

## Como se conectan las areas? {#relaciones}

Las relaciones enlazan personas, productos y cuentas con sus catalogos y registros dependientes. Las tablas `tbd_*` resuelven varias relaciones muchos a muchos o almacenan detalle asociado.

El inventario siguiente incluye todas las columnas fisicas, sus claves y sus referencias. Use las tablas para consultar los detalles completos del esqueema.

## Que guarda cada tabla? {#tablas}

El tipo conserva la declaracion MySQL, incluidos `unsigned`, longitudes y precision. `NULL` indica quee el SQL permite ausencia; los valores por defecto y actualizacion automatica se reproducen literalmente.

## Tabla `tb_carts` - ? Carrito asociado de forma ?nica a una cuenta de usuario. {#tabla-tb_carts}

| Columna (tb_carts) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `int unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `user_ID` | `int unsigned NOT NULL` | UNIQUE, FK - `tb_users.ID` | Identificador de la cuenta de usuario relacionada. |
| `status` | `bit(1) DEFAULT b'1' - NULL permitido` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP - NULL permitido` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** UNIQUE KEY `uk_cart_user` (`user_ID`); FK `tb_carts_ibfk_1`: `user_ID` - `tb_users` `ID`

## Tabla `tb_logs` - ? Bitacora de operaciones y su resultado para tablas de la aplicacion. {#tabla-tb_logs}

| Columna (tb_logs) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `int NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `table_name` | `varchar(100) NOT NULL` | - | Nombre de la tabla afectada por la operacion. |
| `table_operation` | `enum('Create','Read','Update','Delete') NOT NULL` | - | Tipo de operacion registrada: Create, Read, Update o Delete. |
| `db_user` | `varchar(80) NOT NULL` | - | Cuenta de base de datos quee ejecut? la operacion. |
| `operation_description` | `text NOT NULL` | - | Detalle textual de la operacion. |
| `operation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora en quee se registr? la operacion. |
| `operation_status` | `bit(1) DEFAULT b'1' - NULL permitido` | - | Indicador de estaado de la operacion registrado. |

**?ndices y restaricciones:** sin ?ndices adicionales declarados.

## Tabla `tb_people` - ? Datos personales y demograficos vinculados uno a uno con una cuenta. {#tabla-tb_people}

| Columna (tb_people) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `person_ID` | `bigint unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador de la persona. |
| `user_ID` | `int unsigned NOT NULL` | UNIQUE, FK - `tb_users.ID` | Identificador de la cuenta de usuario relacionada. |
| `courtesy_title_ID` | `char(3) NOT NULL` | FK - `tbd_courtesy_titles.courtesy_title_ID` | Cdigo del tratamiento de cortesa relacionado. |
| `given_names` | `varchar(150) NOT NULL` | - | Nombres de la persona. |
| `family_names` | `varchar(150) NOT NULL` | - | Apellidos de la persona. |
| `birth_date` | `date DEFAULT NULL - NULL permitido` | - | Fecha de nacimiento; opcional. |
| `gender_ID` | `tinyint unsigned NOT NULL` | FK - `tbd_genders.gender_ID` | Identificador del gnero relacionado. |
| `country_code` | `char(2) NOT NULL` | FK - `tbd_countries.country_code` | Cdigo de pas relacionado. |
| `phone` | `varchar(25) DEFAULT NULL - NULL permitido` | - | Telfono de contacto; opcional. |
| `created_at` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin de la fila. |
| `updated_at` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP` | - | Fecha y hora de modificacin; se actualiza automaticamente. |
| `is_active` | `tinyint(1) NOT NULL DEFAULT '1'` | - | Indicador de activacin lgica (1 activo, 0 inactivo). |

**?ndices y restaricciones:** UNIQUE KEY `uq_people_user` (`user_ID`); KEY `fk_people_courtesy_title` (`courtesy_title_ID`); KEY `fk_people_gender` (`gender_ID`); KEY `fk_people_country` (`country_code`); FK `fk_people_country`: `country_code` - `tbd_countries` `country_code`; FK `fk_people_courtesy_title`: `courtesy_title_ID` - `tbd_courtesy_titles` `courtesy_title_ID`; FK `fk_people_gender`: `gender_ID` - `tbd_genders` `gender_ID`; FK `fk_people_user`: `user_ID` - `tb_users` `ID`

## Tabla `tb_products` - ? Catlogo de productos, precio vigente e inventario disponible. {#tabla-tb_products}

| Columna (tb_products) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `int unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `SKU` | `varchar(50) NOT NULL` | UNIQUE | Cdigo de inventario del producto; ?unico. |
| `name` | `varchar(250) NOT NULL` | - | Nombre visible o descriptivo. |
| `description` | `text - NULL permitido` | - | Descripcin de la entidad. |
| `current_price` | `decimal(10,2) NOT NULL DEFAULT '0.00'` | - | Precio actual con dos posiciones decimales. |
| `current_stock` | `int unsigned NOT NULL DEFAULT '0'` | - | Existencias actuales no negativas. |
| `status` | `bit(1) DEFAULT b'1' - NULL permitido` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** UNIQUE KEY `SKU` (`SKU`)

## Tabla `tb_user_addresses` - ? Direcciones guardadas por usuarios y su seleccin predeterminada. {#tabla-tb_user_addresses}

| Columna (tb_user_addresses) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `bigint unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `user_ID` | `int unsigned NOT NULL` | FK - `tb_users.ID` | Identificador de la cuenta de usuario relacionada. |
| `label` | `varchar(100) DEFAULT NULL - NULL permitido` | - | Etiqueeta legible asignada por el usuario. |
| `is_default` | `tinyint(1) NOT NULL DEFAULT '0'` | - | Indica si el registro esta? marcado como predeterminado (1 s?, 0 no). |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP - NULL permitido` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** KEY `idx_user_address_user` (`user_ID`); FK `fk_user_address_user`: `user_ID` - `tb_users` `ID` ON DELETE RESTRICT

## Tabla `tb_users` - ? Cuentas, credenciales y actividad de acceso. {#tabla-tb_users}

| Columna (tb_users) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `int unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `email` | `varchar(80) NOT NULL` | UNIQUE | Correo electrunico de la cuenta; ?ndice ?unico. |
| `nick` | `varchar(100) NOT NULL` | UNIQUE | Nombre de usuario; ?ndice ?unico. |
| `password` | `varchar(255) NOT NULL` | - | Valor de credencial almacenado como texto; el DDL no especifica el algoritmo de hash. |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP - NULL permitido` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |
| `last_login` | `datetime DEFAULT NULL - NULL permitido` | - | Fecha y hora del ?ltimo acceso; puede ser NULL si no hay registro. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |

**?ndices y restaricciones:** UNIQUE KEY `email` (`email`); UNIQUE KEY `nickname` (`nick`)

## Tabla `tbc_categories` - ? Categoras jerrqueicas con referencia opcional a una categoria superior. {#tabla-tbc_categories}

| Columna (tbc_categories) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `int unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `name` | `varchar(120) NOT NULL` | UNIQUE | Nombre visible o descriptivo. |
| `description` | `text - NULL permitido` | - | Descripcin de la entidad. |
| `sup_id_category` | `int unsigned DEFAULT NULL - NULL permitido` | FK - `tbc_categories.ID` | Identificador de la categoria superior; NULL para categoria raz. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** UNIQUE KEY `name` (`name`); KEY `fk_superior_category` (`sup_id_category`); FK `fk_superior_category`: `sup_id_category` - `tbc_categories` `ID`

## Tabla `tbc_payment_methods_types` - ? Catlogo de tipos de medios de pago. {#tabla-tbc_payment_methods_types}

| Columna (tbc_payment_methods_types) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `int unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `code` | `varchar(30) NOT NULL` | UNIQUE | Cdigo ?unico del tipo de medio de pago. |
| `description` | `text NOT NULL` | - | Descripcin de la entidad. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP - NULL permitido` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** UNIQUE KEY `code_UNIQUE` (`code`)

## Tabla `tbd_address_components` - ? Componentes jerrqueicos quee forman una direccion guardada. {#tabla-tbd_address_components}

| Columna (tbd_address_components) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `bigint unsigned NOT NULL AUTO_INCREMENT` | PK, UNIQUE | Identificador interno de la fila. |
| `address_ID` | `bigint unsigned NOT NULL` | UNIQUE, FK - `tbd_address_components.address_ID` | Identificador de la direccion a la quee pertenece el componente. |
| `value` | `varchar(255) NOT NULL` | - | Valor textual del componente de direccion. |
| `component_type` | `varchar(50) NOT NULL` | - | Tipo de componente de direccion. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `address_sup_ID` | `bigint unsigned DEFAULT NULL - NULL permitido` | FK - `tbd_address_components.ID` | Identificador del componente padre dentro de la misma direccion; NULL indica raz. |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP - NULL permitido` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** UNIQUE KEY `uk_address_component` (`address_ID`,`ID`); KEY `idx_address_parent` (`address_ID`,`address_sup_ID`); FK `fk_component_address`: `address_ID` - `tb_user_addresses` `ID` ON DELETE RESTRICT; FK `fk_component_parent`: `address_ID`, `address_sup_ID` - `tbd_address_components` `address_ID`, `ID` ON DELETE RESTRICT

## Tabla `tbd_countries` - ? Catlogo de pases indexado por cdigo ISO de dos caracteres. {#tabla-tbd_countries}

| Columna (tbd_countries) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `country_code` | `char(2) NOT NULL` | PK | Cdigo de pas relacionado. |
| `name` | `varchar(100) NOT NULL` | UNIQUE | Nombre visible o descriptivo. |
| `phone_code` | `varchar(8) DEFAULT NULL - NULL permitido` | - | Prefijo telefunico internacional; opcional. |
| `is_active` | `tinyint(1) NOT NULL DEFAULT '1'` | - | Indicador de activacin lgica (1 activo, 0 inactivo). |

**?ndices y restaricciones:** UNIQUE KEY `uq_country_name` (`name`)

## Tabla `tbd_courtesy_titles` - ? Catlogo de tratamientos o ttulos de cortesa. {#tabla-tbd_courtesy_titles}

| Columna (tbd_courtesy_titles) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `courtesy_title_ID` | `char(3) NOT NULL` | PK | Cdigo del tratamiento de cortesa relacionado. |
| `name` | `varchar(50) NOT NULL` | UNIQUE | Nombre visible o descriptivo. |
| `is_active` | `tinyint(1) NOT NULL DEFAULT '1'` | - | Indicador de activacin lgica (1 activo, 0 inactivo). |

**?ndices y restaricciones:** UNIQUE KEY `uq_courtesy_title_name` (`name`)

## Tabla `tbd_genders` - ? Catlogo de gneros. {#tabla-tbd_genders}

| Columna (tbd_genders) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `gender_ID` | `tinyint unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador del gnero relacionado. |
| `name` | `varchar(50) NOT NULL` | UNIQUE | Nombre visible o descriptivo. |
| `is_active` | `tinyint(1) NOT NULL DEFAULT '1'` | - | Indicador de activacin lgica (1 activo, 0 inactivo). |

**?ndices y restaricciones:** UNIQUE KEY `uq_gender_name` (`name`)

## Tabla `tbd_products_categories` - ? Relacin muchos a muchos entre productos y categorias. {#tabla-tbd_products_categories}

| Columna (tbd_products_categories) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `category_ID` | `int unsigned NOT NULL` | PK, FK - `tbc_categories.ID` | Identificador de la categoria relacionada. |
| `product_ID` | `int unsigned NOT NULL` | PK, FK - `tb_products.ID` | Identificador del producto relacionado. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** KEY `fk_product` (`product_ID`); FK `fk_category`: `category_ID` - `tbc_categories` `ID`; FK `fk_product`: `product_ID` - `tb_products` `ID`

## Tabla `tbd_products_users_providers` - ? Relacin usuario-producto quee registra titularidad o disponibilidad. {#tabla-tbd_products_users_providers}

| Columna (tbd_products_users_providers) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `user_ID` | `int unsigned NOT NULL` | PK, FK - `tb_users.ID` | Identificador de la cuenta de usuario relacionada. |
| `product_ID` | `int unsigned NOT NULL` | PK, FK - `tb_products.ID` | Identificador del producto relacionado. |
| `type_ownership` | `varchar(50) DEFAULT NULL - NULL permitido` | - | Tipo de titularidad del producto; opcional. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `avalaible_date` | `datetime DEFAULT NULL - NULL permitido` | - | Fecha y hora de disponibilidad (nombre conservado tal como aparece en SQL); opcional. |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** KEY `fk_product_provider` (`product_ID`); FK `fk_product_provider`: `product_ID` - `tb_products` `ID`; FK `fk_user_provider`: `user_ID` - `tb_users` `ID`

## Tabla `tbd_user_payment_methods` - ? Referencias tokenizadas a mtodos de pago de proveedores. {#tabla-tbd_user_payment_methods}

| Columna (tbd_user_payment_methods) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `ID` | `bigint unsigned NOT NULL AUTO_INCREMENT` | PK | Identificador interno de la fila. |
| `user_ID` | `int unsigned NOT NULL` | FK - `tb_users.ID` | Identificador de la cuenta de usuario relacionada. |
| `payment_method_type_ID` | `int unsigned NOT NULL` | FK - `tbc_payment_methods_types.ID` | Identificador del tipo de medio de pago. |
| `provider` | `varchar(60) NOT NULL` | UNIQUE | Nombre del proveedor de pagos. |
| `provider_method_ref` | `varchar(255) NOT NULL` | UNIQUE | Referencia externa del mtodo de pago (el DDL no define su formato). |
| `label` | `varchar(100) DEFAULT NULL - NULL permitido` | - | Etiqueeta legible asignada por el usuario. |
| `last_four` | `char(4) DEFAULT NULL - NULL permitido` | - | ?ltimos cuatro caracteres asociados al medio de pago. |
| `is_default` | `tinyint(1) NOT NULL DEFAULT '0'` | - | Indica si el registro esta? marcado como predeterminado (1 s?, 0 no). |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP - NULL permitido` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** UNIQUE KEY `uk_provider_method` (`provider`,`provider_method_ref`); KEY `user_ID` (`user_ID`); KEY `payment_method_type_ID` (`payment_method_type_ID`); FK `tbd_user_payment_methods_ibfk_1`: `user_ID` - `tb_users` `ID`; FK `tbd_user_payment_methods_ibfk_2`: `payment_method_type_ID` - `tbc_payment_methods_types` `ID`

## Tabla `tbd_users_wishlist_products` - ? Relacin de productos guardados en listas de deseos. {#tabla-tbd_users_wishlist_products}

| Columna (tbd_users_wishlist_products) | Tipo SQL y reglas | Clave / referencia | Descripcin |
| --- | --- | --- | --- |
| `user_ID` | `int unsigned NOT NULL` | PK, FK - `tb_users.ID` | Identificador de la cuenta de usuario relacionada. |
| `product_ID` | `int unsigned NOT NULL` | PK, FK - `tb_products.ID` | Identificador del producto relacionado. |
| `status` | `bit(1) NOT NULL DEFAULT b'1'` | - | Indicador binario de estaado del registro (convencion 1/0, segn la aplicacion). |
| `creation_date` | `datetime NOT NULL DEFAULT CURRENT_TIMESTAMP` | - | Fecha y hora de creacin del registro. |
| `last_update` | `datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP` | - | Fecha y hora de ?ultima actualizacion; se actualiza automaticamente cuando esta? definido en el DDL. |

**?ndices y restaricciones:** KEY `fk_products3` (`product_ID`); FK `fk_products3`: `product_ID` - `tb_products` `ID`; FK `fk_user2`: `user_ID` - `tb_users` `ID`

Qu? columnas exponen las vistas? {#vistas}

El respaldo define las expresiones SQL de estaas vistas. Sus columnas son resultados de consultas y no poseen tipo ni nulabilidad declarados de forma independiente en `CREATE VIEW`.

## Vista `vw_total_products_by_category` {#vista-vw_total_products_by_category}

Resumen por categoria y una fila adicional para productos sin categoria. Incluye jerarquea recursiva y conteos de productos activos/inactivos.

| Salida (vw_total_products_by_category) | Tipo | Descripcin |
| --- | --- | --- |
| `category_ID` | Derivado | Identificador de categoria; puede ser NULL en la fila agregada de productos sin categoria. |
| `category_path` | Derivado | Ruta de nombres de categoria calculada por recursin. |
| `category_level` | Derivado | Profundidad de la categoria (raz = 1; fila sin categoria = 0). |
| `total_products` | Derivado | Conteo distinto de productos asociados a la categoria. |
| `total_active_products` | Derivado | Conteo distinto de productos con estaado activo. |
| `total_inactive_products` | Derivado | Conteo distinto de productos con estaado inactivo. |
| `total_uncategorized_products` | Derivado | Conteo de productos sin vnculo de categoria activo; cero en filas de categoria. |

## Vista `vw_trazabilidad_categorias` {#vista-vw_trazabilidad_categorias}

Filtra la bitcora para operaciones sobre `tbc_categories`; extrae el ID de categoria y deriva usuario/roles desde la cuenta registrada.

| Salida (vw_trazabilidad_categorias) | Tipo | Descripcin |
| --- | --- | --- |
| `log_id` | Derivado | Identificador de `tb_logs.ID`. |
| `category_id` | Derivado | Identificador extraido de `operation_description`; el alias se conserva como esta? definido. |
| `operation` | Derivado | Tipo de operacion de la bitcora. |
| `db_user` | Derivado | Cuenta MySQL registrada en la bitcora. |
| `username` | Derivado | Parte anterior a `@` de `db_user`. |
| `roles` | Derivado | Roles agregados desde `mysql.role_edges`; puede devolver texto de reserva. |
| `operation_description` | Derivado | Detalle original de la operacion. |
| `operation_date` | Derivado | Fecha y hora registradas en la bitcora. |
| `operation_status` | Derivado | Estado registrado de la operacion. |

## Vista `vw_trazabilidad_categorizacion_productos` {#vista-vw_trazabilidad_categorizacion_productos}

Filtra la bitcora de cambios de `tbd_products_categories`; extrae el ID desde la descripcion.

| Salida (vw_trazabilidad_categorizacion_productos) | Tipo | Descripcin |
| --- | --- | --- |
| `log_id` | Derivado | Identificador de `tb_logs.ID`. |
| `category_id` | Derivado | Identificador extraido de `operation_description`; el alias se conserva como esta? definido. |
| `operation` | Derivado | Tipo de operacion de la bitcora. |
| `db_user` | Derivado | Cuenta MySQL registrada en la bitcora. |
| `username` | Derivado | Parte anterior a `@` de `db_user`. |
| `roles` | Derivado | Roles agregados desde `mysql.role_edges`; puede devolver texto de reserva. |
| `operation_description` | Derivado | Detalle original de la operacion. |
| `operation_date` | Derivado | Fecha y hora registradas en la bitcora. |
| `operation_status` | Derivado | Estado registrado de la operacion. |

## Vista `vw_trazabilidad_producto_proveedor` {#vista-vw_trazabilidad_producto_proveedor}

Filtra la bitcora de cambios en `tbd_products_users_providers`; el alias `category_id` proviene del ID extraido de la descripcion, aunquee se refiere a una operacion de proveedor.

| Salida (vw_trazabilidad_producto_proveedor) | Tipo | Descripcin |
| --- | --- | --- |
| `log_id` | Derivado | Identificador de `tb_logs.ID`. |
| `category_id` | Derivado | Identificador extraido de `operation_description`; el alias se conserva como esta? definido. |
| `operation` | Derivado | Tipo de operacion de la bitcora. |
| `db_user` | Derivado | Cuenta MySQL registrada en la bitcora. |
| `username` | Derivado | Parte anterior a `@` de `db_user`. |
| `roles` | Derivado | Roles agregados desde `mysql.role_edges`; puede devolver texto de reserva. |
| `operation_description` | Derivado | Detalle original de la operacion. |
| `operation_date` | Derivado | Fecha y hora registradas en la bitcora. |
| `operation_status` | Derivado | Estado registrado de la operacion. |

## Vista `vw_trazabilidad_productos` {#vista-vw_trazabilidad_productos}

Relaciona productos con operaciones Create en `tb_logs`; presenta datos del producto, autor, roles y detalle/fecha del registro.

| Salida (vw_trazabilidad_productos) | Tipo | Descripcin |
| --- | --- | --- |
| `id` | Derivado | Identificador del producto. |
| `name` | Derivado | Nombre del producto. |
| `description` | Derivado | Descripcin del producto. |
| `inserted_by` | Derivado | Cuenta quee aparece como autora de la operacion Create. |
| `roles` | Derivado | Roles agregados desde `mysql.role_edges`; puede devolver texto de reserva. |
| `operation_description` | Derivado | Detalle original de la operacion. |
| `operation_date` | Derivado | Fecha y hora registradas en la bitcora. |

## Vista `vw_trazabilidad_usuarios` {#vista-vw_trazabilidad_usuarios}

Relaciona usuarios con operaciones Create en `tb_logs` por coincidencia textual de nick y correo; muestara autor, roles y fecha.

| Salida (vw_trazabilidad_usuarios) | Tipo | Descripcin |
| --- | --- | --- |
| `nick` | Derivado | Nombre de usuario. |
| `email` | Derivado | Correo de usuario. |
| `inserted_by` | Derivado | Cuenta quee aparece como autora de la operacion Create. |
| `roles` | Derivado | Roles agregados desde `mysql.role_edges`; puede devolver texto de reserva. |
| `operation_description` | Derivado | Detalle original de la operacion. |
| `operation_date` | Derivado | Fecha y hora registradas en la bitcora. |

Qu? convenciones y lmites debo tener en cuenta? {#limites}

- Las descripciones de negocio se infieren de nombres, claves y expresiones del respaldo; el DDL no incluye comentarios de columna.
- Las columnas booleanas usan `bit(1)` o `tinyint(1)`; el significado exacto de sus valores depende de la aplicacion, salvo cuando el nombre y valor por defecto lo aclaran.
- `tb_users.password` no especifica en el esqueema si el valor esta? hasheado. El diccionario no muestara datos de cuentas.
- La vista de proveedores conserva el alias `category_id` tal como aparece en SQL; su nombre puede inducir a error.
- Se documentan columnas y restaricciones del SQL. No se afirma quee Pages tenga acceso a la base de datos ni quee ejecute estaas vistas.

## Alcance del documento {#alcance}

Fuente: `backups/respaldo22102026.sql`, respaldo MySQL 8.0.42 con base indicada `db_testa_240161`; el volcado incluye SQL de MySQL 8.3 y collation `utf8mb4_0900_ai_ci`. Los tipos de salida de vistas se marcan como derivados porquee el dump no los declara en las vistas.
