# postgrescstore

Docker image of PostgreSQL 11 with an Alpine base and the [`cstore_fdw`](https://github.com/citusdata/cstore_fdw) extension.

### Usage

Just like the [official `postgres` image](https://hub.docker.com/_/postgres?tab=description).

```
docker pull erizocosmico/postgrescstore
```

Extension is automatically activated and the foreign data wrapper server created as `cstore_server`.

You can create tables as follows:

```sql
CREATE FOREIGN TABLE my_table
(
    my_column_1 INTEGER,
    my_column_2 INTEGER
) SERVER cstore_server OPTIONS(compression 'pglz');
```

### Credits

Based on [docker-postgresql-cstore](https://github.com/mnementh64/docker-postgresql-cstore) and adapted to an Alpine base.

### LICENSE

MIT, see [LICENSE](/LICENSE)
