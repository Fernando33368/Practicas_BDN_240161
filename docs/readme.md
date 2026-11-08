# Diccionario de datos de `db_test_240161`

Este sitio documenta las tablas del respaldo `backups/respaldo_db_test_240161.sql`.

- 26 tablas y 215 columnas
- 39 llaves foráneas
- 27 vistas incluidas en el respaldo
- 22,013 filas insertadas en total en las tablas con datos

La página permite buscar por tabla o columna y consultar tipos SQL, nulabilidad, llaves, valores por defecto y restricciones. Los conteos corresponden a los `INSERT` del respaldo.

## Regenerar la página

Con Node.js disponible, ejecuta desde la raíz del repositorio:

```sh
node scripts/generate_data_dictionary.mjs
```

El workflow de GitHub Pages publica el contenido de esta carpeta al actualizar `master` o `Practica03`.
