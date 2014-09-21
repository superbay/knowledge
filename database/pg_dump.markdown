### Exporting

In Terminal, type one of the following. There may be other flags you’d like to append; put those in before the > sign.

#### Uncompressed:
```
$ pg_dump -h IP_ADDRESS -p 5432 -U app -c -N postgis -N topology -d DATABASE_NAME > your_file_name.sql
```
#### Compressed:

```
$ pg_dump -h IP_ADDRESS -p 5432 -U app -a -N postgis -N topology -Fc -d DATABASE_NAME > your_file_name.dump
```

The variables

IP_ADDRESS = The IP address of your database server

DATABASE_NAME = The database name of your server (found on the Database tab of your app)

The flags
```
-h = Host
-p = Port
-U = User
-d = Database name
-N = Exclude schema (in particular, exclude the PostGIS and topology schema if you aren’t using any of their geographic functionality)
-Fc = Format compressed
Optional flags

-a = Data only
-c = Clean
```
You will then be prompted to enter the database password. This is on the Database tab. Click Show to view the password.

NOTE: If you’re exporting your database from an external hosting provider like Heroku, please check their documentation.

### Importing

Much like Exporting, there’s only one step. However the command to use will depend on the type of file created during the Export process. If using an external hosting provider’s backup file, you will most likely need to use the command for Compressed files. The commands and flags are very similar to pg_dump with some slight nuances.

WARNING: This will override your database! If unsure, backup your database before overriding it.

#### Uncompressed:

```
$ psql -h IP_ADDRESS -p 5432 -d database_name -U app -f your_file_name.sql
```

#### Compressed:

```
$ pg_restore -h IP_ADDRESS -p 5432 -U app -d DATABASE_NAME your_file_name.dump
```
A word on importing. Running the import command most likely will produce errors, such as “Error: role app already exists.” This is expected behavior as the database that you’re importing into already has been created; tables, keys, and roles will already exist. However the data should transfer amicably. It is a good idea to confirm that your actual data (not tables or schema) has been transferred properly.
