### updated on 01/09/2021

#### support amazon linux 2




Moreover, if you think PostgreSQL v10 can resolve your issues. You can try these commands:

```
sudo yum update -y

sudo amazon-linux-extras enable postgresql11

```

After having PostgreSQL in your repository, now you can install:


```
yum clean metadata

yum install postgresql
```



### install postgresql client only


```
sudo apt-get install postgresql
sudo apt-get install libpq-dev
```

could be 

```
sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib
```



### install postgresql in ubuntu 14.04


```ruby
sudo aptitude install postgresql
sudo aptitude install libpq-dev#the library for pg gem

sudo -u postgres psql template1 

# there is a default user postgres 

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



Getting error: Peer authentication failed for user “postgres”, when trying to get pgsql working with rails



If you intend to use password authentication over Unix sockets instead of the peer method, try changing the following pg_hba.conf* line:

from
```ruby
# TYPE DATABASE USER ADDRESS METHOD
local  all      all          peer

```

to

```ruby
# TYPE DATABASE USER ADDRESS METHOD
local  all      all          md5
```
(Of course you can also create more specific rules for a specific database or user.)

You'll need to restart PostgreSQL if it's running. E.g.

```
sudo service postgresql restart
```

and the pg_hba.conf

```
sudo vim /etc/postgresql/9.3/main/pg_hba.conf 
```
