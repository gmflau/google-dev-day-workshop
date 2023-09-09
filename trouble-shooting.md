# trouble-shooting guide

#### database-seed
```
pod/database-seed                            1/2     Error     0          7m50s
```

##### Scenario 1:
**Error Message**
```
Prisma schema loaded from prisma/schema.prisma
Datasource "db": PostgreSQL database "dbFashion", schema "public" at "35.226.175.237:5432"
Error: insert or update on table "orderProducts" violates foreign key constraint "orderProducts_orderId_fkey"
  0: sql_schema_connector::apply_migration::migration_step
      with step=AddForeignKey { foreign_key_id: ForeignKeyId(1) }
       at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:21
  1: sql_schema_connector::apply_migration::apply_migration
       at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:10
  2: schema_core::state::SchemaPush
       at schema-engine/core/src/state.rs:433
```
**Reason**
Active logical replication slot with Debezium
```
postgres=> SELECT * FROM pg_replication_slots ;
 slot_name |  plugin  | slot_type | datoid | database  | temporary | active | active_pid | xmin | catalog_xmin | restart_lsn | confirmed_flush_lsn | wal_status | safe_wal_size | two_phase 
-----------+----------+-----------+--------+-----------+-----------+--------+------------+------+--------------+-------------+---------------------+------------+---------------+-----------
 debezium  | pgoutput | logical   |  16482 | dbFashion | f         | t      |      37266 |      |        19849 | 0/23F2898   | 0/2406158           | reserved   |               | f
(1 row)
```
**Resolution**
```bash
kubectl delete -f /tmp/debezium-server-pod.yml
```


