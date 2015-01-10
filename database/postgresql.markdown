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


```ruby

db_tasks = %w[db:migrate db:migrate:up db:migrate:down db:rollback db:forward]

namespace :multitenant do
  db_tasks.each do |task_name|
    desc "Run #{task_name} for each tenant"
    task task_name => %w[environment db:load_config] do
      Tenant.find_each do |tenant|
        puts "Running #{task_name} for tenant#{tenant.id} (#{tenant.subdomain})"
        tenant.scope_schema { Rake::Task[task_name].execute }
      end
    end
  end
end

db_tasks.each do |task_name|
  Rake::Task[task_name].enhance(["multitenant:#{task_name}"])
end

```


#### FATAL: Peer authentication failed for user (PG::Error)

The problem is still your pg_hba.conf file. This line:

```
local   all             postgres                                peer
```

Should be

```
local   all             postgres                                trust
```

```
/etc/postgresql/9.1/main/pg_hba.conf


sudo service postgreql restart


After installing ppostgresql I did the below steps.

open the file pg_hba.conf for ubuntu it will be in /etc/postgresql/9.x/main and change the this line:
local   all             postgres                                peer
to

local   all             postgres                                trust
Restart the server
sudo service postgresql restart
Login into psql and set your passowrd
psql -U postgres

ALTER USER postgres with password 'your-pass';
Finally change the pg_hba.conf from
local   all             postgres                                trust
to

local   all             postgres                                md5
After restarting the postgresql server, you can access it with your own password

Authentication methods details:

trust - anyone who can connect to the server is authorized to access the database

peer - use client's operating system user name as database user name to access it.

md5 - password-base authentication

for further reference check here
```
