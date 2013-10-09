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
