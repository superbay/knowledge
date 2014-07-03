### Some basic usage


```ruby

sudo -u postgres psql template1

CREATE USER tom WITH PASSWORD 'myPassword';

ALTER USER postgres with encrypted password 'your_password';

CREATE DATABASE pg_development;  
#CREATE DATABASE  


grant all privileges on database postgres to postgres; 

alter user livegamer with superuser; 



sudo nano /etc/postgresql/9.1/main/postgresql.conf

#localhost


listen_addresses = 'localhost'  
```





working for local macbook air

```ruby
psql -d postgres
```


```ruby
mysql: SHOW TABLES
postgresql: \d
postgresql: SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

mysql: SHOW DATABASES
postgresql: \l
postgresql: SELECT datname FROM pg_database;

mysql: SHOW COLUMNS
postgresql: \d table
postgresql: SELECT column_name FROM information_schema.columns WHERE table_name ='table';

mysql: DESCRIBE TABLE
postgresql: \d+ table
postgresql: SELECT column_name FROM information_schema.columns WHERE table_name ='table';

```

### Brew install postgresql


#### brew restart postgresql

```
brew services restart postgresql

```


[offical reference](http://www.postgresql.org/docs/9.3/static/server-start.html)



Postgresql version: 9.3.2

```ruby
#Steps to install and run PostgreSQL 9.2 using Homebrew (Mac OS X)
#(if you aren't using version 9.1.5, change line 6 with the correct version)
 
1. launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
2. mv /usr/local/var/postgres /usr/local/var/postgres91
3. brew update
4. brew upgrade postgresql
5. initdb /usr/local/var/postgres -E utf8 # create database
6. pg_upgrade -b /usr/local/Cellar/postgresql/9.1.5/bin -B /usr/local/Cellar/postgresql/9.2.0/bin -d /usr/local/var/postgres91 -D /usr/local/var/postgres
7. cp /usr/local/Cellar/postgresql/9.2.0/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
8. pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
 
#If you're using ruby, also:
 
gem pristine pg

```


#### some other


```ruby
psql -U postgres -h localhost#9.2有一个默认的数据库用户就是，当前系统用户。不注意的话就会很讨厌
grant all privileges on database postgres to postgres;
alter user livegamer with superuser;
\du
alter user postgres with encrypted password 'postgres';

```

#### some permit issue


```ruby

ps -ef | grep postmaster
These two files are the -D directory (maybe /usr/local/pgsql/data).

For the postgresql.conf file, uncomment the listen_address and change it to be:

listen_address = '*'
For the pg_hba.conf add the line:

host all all 0.0.0.0/0 md5

```


#### 


```ruby

brew install postres
initdb /usr/local/var/postgres
mkdir -p ~/Library/LaunchAgents
cp /usr/local/Cellar/postgresql/9.0.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist
If you need a gem for posgres do:
env ARCHFLAGS="-arch x86_64" gem install pg
Install Instrumentation, in my case (postgres version 9.0.4):
psql -d postgres < /usr/local/Cellar/postgresql/9.0.4/share/postgresql/contrib/adminpack.sql
At this moment, you installed postgress (it’s only a note). Ok, let’s create a new role:
psql -d postgres
With this command, you’ll see all roles created:
postgres-# \du
We create a new user called postgres like this way:
postgres=# CREATE ROLE postgres SUPERUSER CREATEDB CREATEROLE LOGIN;
And that’s all. If you list all users again you’ll see that a new user has been created.
```


Getting hands on postgres terminal 
1. Login onto terminal 
```
psql -U DB_USERNAME -d DB_NAME -W DB_PASSWORD 

```
2. List databases 

\l 
3. Display tables 

\dt 
4. Exit from terminal 

\q
