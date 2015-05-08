### dump from heroku

```ruby
 heroku pg:backups capture
 curl -o latest.dump `heroku pg:backups public-url -a sushi`

 PGPASSWORD=mypassword pg_restore --verbose --clean --no-acl --no-owner -h localhost -U myuser -d mydb latest.dump
 
 
 PGPASSWORD=mypassword pg_dump -Fc --no-acl --no-owner -h localhost -U myuser mydb > mydb.dump
 
 heroku pg:backups restore 'https://s3.amazonaws.com/me/items/3H0q/mydb.dump' DATABASE -a sushi
 
 
 heroku pg:psql


```

https://devcenter.heroku.com/articles/heroku-postgres-import-export


http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL.Procedural.Importing.html

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


### ninefold working

```ruby
pg_dump -h hostname -p 5432 -U app -N postgis -N topology -d database -c > backup11_29.sql

psql -h localhost -p 5432 -U app -d database -f backup11_29.sql

```
