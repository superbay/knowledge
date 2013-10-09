### Postgres

```ruby
rails db
\dt # list all the relations could be tables

#create the schema
CREATE SCHEMA foo;

#added schema to current search path
SET search_path TO foo, public;

#create table under that schema
CREATE TABLE foo.items ();

# remove the schema we just created
DROP SCHEMA foo CASCADE;
```
