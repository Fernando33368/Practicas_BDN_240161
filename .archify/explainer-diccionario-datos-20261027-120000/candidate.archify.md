# Diccionario de datos de db_test_240161 {#diccionario-datos}

El respaldo contiene **22 tablas y 168 columnas**. Esta página documenta sus descripciones, composición formal y dominios SQL, cardinalidad, naturaleza, almacenamiento, nulabilidad y llaves. El esquema corresponde a MySQL 8.3.0.

- Las restricciones y tipos se transcriben del archivo `backups/respaldo27102026.sql`.
- Los dominios ENUM y las relaciones FK se muestran explícitamente.
- Las descripciones semánticas son inferencias cuando el respaldo no aporta documentación funcional.

@answer scope="Diccionario del DDL del respaldo del 27 de octubre de 2026"
@meta locale=es style=product

## Criterios de lectura {#criterios}

Cada atributo es **monovalor** por columna y fila; incluso `TEXT` representa un único valor. La naturaleza de los identificadores numéricos es cuantitativa por representación, aunque su función sea identificar registros. `AUTO_INCREMENT` y marcas temporales autom?ticas se clasifican como gestionados autom?ticamente; no se detectan columnas generadas mediante expresiones.

Los tipos `VARCHAR` y `TEXT` sin restricciones CHECK no tienen un dominio de negocio declarado. El dominio indicado refleja el límite o conjunto que permite el tipo SQL, sin afirmar validaciones externas.

## Tabla `tb_cancellations` ? descripci?n general {#tabla-tb_cancellations}

Tb cancellations conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`payment_ID\` | Identificador del pago relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_payments.ID |
| \`requested_by_user_ID\` | Dato requested by user id; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`reason\` | Motivo textual. | \`text\`; Dominio representado por text NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`cancellation_status\` | Dato cancellation status; interpretaci?n inferida del nombre de columna. | \`enum('Pending','Approved','Rejected','Completed')\`; ENUM {Pending, Approved, Rejected, Completed} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_carts` ? descripci?n general {#tabla-tb_carts}

Tb carts conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID + UNIQUE |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Opcional (NULL permitido); No es llave declarada |

## Tabla `tb_logs` ? descripci?n general {#tabla-tb_logs}

Tb logs conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int\`; Dominio representado por int NOT NULL AUTO_INCREMENT. | Monovalor; Cuantitativa discreta | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`table_name\` | Dato table name; interpretaci?n inferida del nombre de columna. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`table_operation\` | Dato table operation; interpretaci?n inferida del nombre de columna. | \`enum('Create','Read','Update','Delete')\`; ENUM {Create, Read, Update, Delete} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`db_user\` | Dato db user; interpretaci?n inferida del nombre de columna. | \`varchar(80)\`; Cadena de hasta 80 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`operation_description\` | Dato operation description; interpretaci?n inferida del nombre de columna. | \`text\`; Dominio representado por text NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`operation_date\` | Dato operation date; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`operation_status\` | Dato operation status; interpretaci?n inferida del nombre de columna. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |

## Tabla `tb_payment_transactions` ? descripci?n general {#tabla-tb_payment_transactions}

Tb payment transactions conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`payment_ID\` | Identificador del pago relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_payments.ID |
| \`transaction_type\` | Dato transaction type; interpretaci?n inferida del nombre de columna. | \`enum('Charge','Refund','Authorization','Void')\`; ENUM {Charge, Refund, Authorization, Void} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`amount\` | Importe monetario. | \`decimal(10,2)\`; Dominio representado por decimal(10,2) NOT NULL DEFAULT '0.00'. | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`currency\` | C?digo de moneda. | \`varchar(3)\`; Cadena de hasta 3 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`gateway_transaction_id\` | Dato gateway transaction id; interpretaci?n inferida del nombre de columna. | \`varchar(255)\`; Cadena de hasta 255 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`gateway_response\` | Dato gateway response; interpretaci?n inferida del nombre de columna. | \`text\`; Texto variable; sin límite funcional CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`operation_status\` | Dato operation status; interpretaci?n inferida del nombre de columna. | \`enum('Pending','Completed','Failed','Cancelled')\`; ENUM {Pending, Completed, Failed, Cancelled} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_payments` ? descripci?n general {#tabla-tb_payments}

Tb payments conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`payment_method_type_ID\` | Dato payment method type id; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbc_payment_method_types.ID |
| \`user_payment_method_ID\` | Dato user payment method id; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned DEFAULT NULL. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido);  + FK ? tbd_user_payment_methods.ID |
| \`total_amount\` | Importe total del pago. | \`decimal(10,2)\`; Dominio representado por decimal(10,2) NOT NULL DEFAULT '0.00'. | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`currency\` | C?digo de moneda. | \`varchar(3)\`; Cadena de hasta 3 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_people` ? descripci?n general {#tabla-tb_people}

Tb people conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`person_ID\` | Dato person id; interpretaci?n inferida del nombre de columna. | \`bigint unsigned\`; Dominio representado por bigint unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID + UNIQUE |
| \`courtesy_title_ID\` | Dato courtesy title id; interpretaci?n inferida del nombre de columna. | \`char(3)\`; Cadena de longitud 3; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbd_courtesy_titles.courtesy_title_ID |
| \`given_names\` | Dato given names; interpretaci?n inferida del nombre de columna. | \`varchar(150)\`; Cadena de hasta 150 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`family_names\` | Dato family names; interpretaci?n inferida del nombre de columna. | \`varchar(150)\`; Cadena de hasta 150 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`birth_date\` | Fecha de nacimiento. | \`date\`; Dominio representado por date DEFAULT NULL. | Monovalor; Temporal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`gender_ID\` | Dato gender id; interpretaci?n inferida del nombre de columna. | \`tinyint unsigned\`; Dominio representado por tinyint unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbd_genders.gender_ID |
| \`country_code\` | C?digo del pa?s. | \`char(2)\`; Cadena de longitud 2; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbd_countries.country_code |
| \`phone\` | Tel?fono de contacto. | \`varchar(25)\`; Cadena de hasta 25 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`created_at\` | Dato created at; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`updated_at\` | Dato updated at; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`is_active\` | Indicador de actividad. | \`tinyint(1)\`; 0 o 1 seg?n convenci?n; tinyint(1) NOT NULL DEFAULT '1' | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_products` ? descripci?n general {#tabla-tb_products}

Tb products conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`SKU\` | Clave comercial del producto. | \`varchar(50)\`; Cadena de hasta 50 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`name\` | Nombre legible. | \`varchar(250)\`; Cadena de hasta 250 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`description\` | Descripci?n textual. | \`text\`; Texto variable; sin límite funcional CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`current_price\` | Precio actual del producto. | \`decimal(10,2)\`; Dominio representado por decimal(10,2) NOT NULL DEFAULT '0.00'. | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`current_stock\` | Existencia actual. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL DEFAULT '0'. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_refunds` ? descripci?n general {#tabla-tb_refunds}

Tb refunds conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`payment_ID\` | Identificador del pago relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_payments.ID |
| \`cancellation_ID\` | Dato cancellation id; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned DEFAULT NULL. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido);  + FK ? tb_cancellations.ID |
| \`return_ID\` | Dato return id; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned DEFAULT NULL. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido);  + FK ? tb_returns.ID |
| \`refund_amount\` | Dato refund amount; interpretaci?n inferida del nombre de columna. | \`decimal(10,2)\`; Dominio representado por decimal(10,2) NOT NULL DEFAULT '0.00'. | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`refund_reason\` | Dato refund reason; interpretaci?n inferida del nombre de columna. | \`text\`; Dominio representado por text NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`refund_status\` | Dato refund status; interpretaci?n inferida del nombre de columna. | \`enum('Pending','Processing','Completed','Failed')\`; ENUM {Pending, Processing, Completed, Failed} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`gateway_refund_id\` | Dato gateway refund id; interpretaci?n inferida del nombre de columna. | \`varchar(255)\`; Cadena de hasta 255 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_returns` ? descripci?n general {#tabla-tb_returns}

Tb returns conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`payment_ID\` | Identificador del pago relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_payments.ID |
| \`product_ID\` | Identificador del producto relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_products.ID |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`quantity\` | Cantidad de unidades. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL DEFAULT '1'. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`return_reason\` | Dato return reason; interpretaci?n inferida del nombre de columna. | \`text\`; Dominio representado por text NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`return_status\` | Dato return status; interpretaci?n inferida del nombre de columna. | \`enum('Requested','Received','Inspected','Accepted','Rejected')\`; ENUM {Requested, Received, Inspected, Accepted, Rejected} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_shipments` ? descripci?n general {#tabla-tb_shipments}

Tb shipments conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`payment_ID\` | Identificador del pago relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_payments.ID |
| \`shipping_company\` | Dato shipping company; interpretaci?n inferida del nombre de columna. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`tracking_number\` | N?mero de seguimiento log?stico. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`shipping_cost\` | Costo de env?o. | \`decimal(10,2)\`; Dominio representado por decimal(10,2) NOT NULL DEFAULT '0.00'. | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`shipping_status\` | Dato shipping status; interpretaci?n inferida del nombre de columna. | \`enum('Pending','Preparing','Shipped','In_Transit','Delivered','Failed')\`; ENUM {Pending, Preparing, Shipped, In_Transit, Delivered, Failed} | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`shipped_date\` | Dato shipped date; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime DEFAULT NULL. | Monovalor; Temporal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`estimated_delivery_date\` | Dato estimated delivery date; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime DEFAULT NULL. | Monovalor; Temporal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`actual_delivery_date\` | Dato actual delivery date; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime DEFAULT NULL. | Monovalor; Temporal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tb_user_addresses` ? descripci?n general {#tabla-tb_user_addresses}

Tb user addresses conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`bigint unsigned\`; Dominio representado por bigint unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`label\` | Etiqueta descriptiva. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`is_default\` | Indicador de opci?n predeterminada. | \`tinyint(1)\`; 0 o 1 seg?n convenci?n; tinyint(1) NOT NULL DEFAULT '0' | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Opcional (NULL permitido); No es llave declarada |

## Tabla `tb_users` ? descripci?n general {#tabla-tb_users}

Tb users conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`email\` | Correo electrúnico asociado a la cuenta. | \`varchar(80)\`; Cadena de hasta 80 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`nick\` | Nombre de usuario. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`password\` | Credencial de acceso; el esquema no documenta el algoritmo de hash. | \`varchar(255)\`; Cadena de hasta 255 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Opcional (NULL permitido); No es llave declarada |
| \`last_login\` | Dato last login; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime DEFAULT NULL. | Monovalor; Temporal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbc_categories` ? descripci?n general {#tabla-tbc_categories}

Tbc categories conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`name\` | Nombre legible. | \`varchar(120)\`; Cadena de hasta 120 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`description\` | Descripci?n textual. | \`text\`; Texto variable; sin límite funcional CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`sup_id_category\` | Dato sup id category; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned DEFAULT NULL. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido);  + FK ? tbc_categories.ID |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbc_payment_method_types` ? descripci?n general {#tabla-tbc_payment_method_types}

Tbc payment method types conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`code\` | Dato code; interpretaci?n inferida del nombre de columna. | \`varchar(30)\`; Cadena de hasta 30 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`description\` | Descripci?n textual. | \`text\`; Dominio representado por text NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Opcional (NULL permitido); No es llave declarada |

## Tabla `tbd_address_components` ? descripci?n general {#tabla-tbd_address_components}

Tbd address components conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`bigint unsigned\`; Dominio representado por bigint unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL);  + UNIQUE |
| \`address_ID\` | Dato address id; interpretaci?n inferida del nombre de columna. | \`bigint unsigned\`; Dominio representado por bigint unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbd_address_components.address_ID + UNIQUE |
| \`value\` | Dato value; interpretaci?n inferida del nombre de columna. | \`varchar(255)\`; Cadena de hasta 255 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`component_type\` | Dato component type; interpretaci?n inferida del nombre de columna. | \`varchar(50)\`; Cadena de hasta 50 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`address_sup_ID\` | Dato address sup id; interpretaci?n inferida del nombre de columna. | \`bigint unsigned\`; Dominio representado por bigint unsigned DEFAULT NULL. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido);  + FK ? tbd_address_components.ID |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Opcional (NULL permitido); No es llave declarada |

## Tabla `tbd_countries` ? descripci?n general {#tabla-tbd_countries}

Tbd countries conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`country_code\` | C?digo del pa?s. | \`char(2)\`; Cadena de longitud 2; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`name\` | Nombre legible. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`phone_code\` | Dato phone code; interpretaci?n inferida del nombre de columna. | \`varchar(8)\`; Cadena de hasta 8 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`is_active\` | Indicador de actividad. | \`tinyint(1)\`; 0 o 1 seg?n convenci?n; tinyint(1) NOT NULL DEFAULT '1' | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbd_courtesy_titles` ? descripci?n general {#tabla-tbd_courtesy_titles}

Tbd courtesy titles conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`courtesy_title_ID\` | Dato courtesy title id; interpretaci?n inferida del nombre de columna. | \`char(3)\`; Cadena de longitud 3; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`name\` | Nombre legible. | \`varchar(50)\`; Cadena de hasta 50 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`is_active\` | Indicador de actividad. | \`tinyint(1)\`; 0 o 1 seg?n convenci?n; tinyint(1) NOT NULL DEFAULT '1' | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbd_genders` ? descripci?n general {#tabla-tbd_genders}

Tbd genders conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`gender_ID\` | Dato gender id; interpretaci?n inferida del nombre de columna. | \`tinyint unsigned\`; Dominio representado por tinyint unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`name\` | Nombre legible. | \`varchar(50)\`; Cadena de hasta 50 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`is_active\` | Indicador de actividad. | \`tinyint(1)\`; 0 o 1 seg?n convenci?n; tinyint(1) NOT NULL DEFAULT '1' | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbd_products_categories` ? descripci?n general {#tabla-tbd_products_categories}

Tbd products categories conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`category_ID\` | Identificador de la categor?a relacionada. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbc_categories.ID |
| \`product_ID\` | Identificador del producto relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); PK + FK ? tb_products.ID |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbd_products_users_providers` ? descripci?n general {#tabla-tbd_products_users_providers}

Tbd products users providers conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`product_ID\` | Identificador del producto relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); PK + FK ? tb_products.ID |
| \`type_ownership\` | Dato type ownership; interpretaci?n inferida del nombre de columna. | \`varchar(50)\`; Cadena de hasta 50 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`avalaible_date\` | Dato avalaible date; interpretaci?n inferida del nombre de columna. | \`datetime\`; Dominio representado por datetime DEFAULT NULL. | Monovalor; Temporal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |

## Tabla `tbd_user_payment_methods` ? descripci?n general {#tabla-tbd_user_payment_methods}

Tbd user payment methods conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`ID\` | Identificador del registro. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL AUTO_INCREMENT. | Monovalor; Cualitativa nominal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`payment_method_type_ID\` | Dato payment method type id; interpretaci?n inferida del nombre de columna. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tbc_payment_method_types.ID |
| \`provider\` | Proveedor externo. | \`varchar(60)\`; Cadena de hasta 60 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`provider_method_ref\` | Dato provider method ref; interpretaci?n inferida del nombre de columna. | \`varchar(255)\`; Cadena de hasta 255 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + UNIQUE |
| \`label\` | Etiqueta descriptiva. | \`varchar(100)\`; Cadena de hasta 100 caracteres; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`last_four\` | ?ltimos cuatro caracteres del medio de pago. | \`char(4)\`; Cadena de longitud 4; sin patr?n CHECK declarado. | Monovalor; Cualitativa nominal | Almacenado; Opcional (NULL permitido); No es llave declarada |
| \`is_default\` | Indicador de opci?n predeterminada. | \`tinyint(1)\`; 0 o 1 seg?n convenci?n; tinyint(1) NOT NULL DEFAULT '0' | Monovalor; Cuantitativa discreta | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Opcional (NULL permitido); No es llave declarada |

## Tabla `tbd_users_wishlist_products` ? descripci?n general {#tabla-tbd_users_wishlist_products}

Tbd users wishlist products conserva los datos relacionados con esta entidad o proceso. Su prop?sito se interpreta a partir de nombres, relaciones y restricciones declaradas en el DDL.

| Columna | Descripci?n | Composici?n formal y dominio | Clasificaci?n | Almacenamiento, nulabilidad y llave |
| --- | --- | --- | --- | --- |
| \`user_ID\` | Identificador del usuario relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL);  + FK ? tb_users.ID |
| \`product_ID\` | Identificador del producto relacionado. | \`int unsigned\`; Dominio representado por int unsigned NOT NULL. | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); PK + FK ? tb_products.ID |
| \`status\` | Indicador de vigencia del registro. | \`bit(1)\`; 0 o 1 seg?n convenci?n; bit(1) NOT NULL DEFAULT b'1' | Monovalor; Cualitativa nominal | Almacenado; Obligatorio (NOT NULL); No es llave declarada |
| \`creation_date\` | Fecha y hora de creaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL DEFAULT CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
| \`last_update\` | Fecha y hora de ?ltima actualizaci?n. | \`datetime\`; Dominio representado por datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP. | Monovalor; Temporal | Derivado/gestionado autom?ticamente; Obligatorio (NOT NULL); No es llave declarada |
