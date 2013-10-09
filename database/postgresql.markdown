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

```ruby
t = Tenant.create! subdomain: "cheese"
c = t.connection
c.execute("create schema tenant1")
c.schema_search_path = "tenant1"
load 'db/schema.rb'
```
