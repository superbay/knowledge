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
