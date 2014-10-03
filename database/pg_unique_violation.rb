Fixing: PG::UniqueViolation: ERROR: Duplicate Key Value Violates Unique Constraint 'Your_table_name_pkey'


Postgresql maintain a internal value which is the max value of the id column of a given table. And uses this to generate values for primary keys when you insert new records. Sometimes this internally stored value can get messed up. And that can cause the error above when you are trying to insert a new record to the table.


```
SELECT setval('company_id_seq', (SELECT max(id) FROM company));

```


```
pg_dump -U user_name database_name -f database_backup_name.sql
cd /your/rails/app/root/
rails db production

```


```

SELECT setval('your_table_id_seq', (SELECT MAX(id) FROM your_table));

```

replace your_table with whatever the table name you are using. And the code above assumes your primary key column name is id.


need to find the seq name


```
ALTER SEQUENCE sequence_name RESTART WITH next_id_in_line;.

```
![screen shot 2014-10-03 at 11 29 27 am](https://cloud.githubusercontent.com/assets/83296/4508037/1ffafce6-4b12-11e4-9ed7-0c38be258eb3.png)
