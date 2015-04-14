### force ssl

http://aws.amazon.com/rds/faqs/#53


### change my.cnf
```
#Replace xxx with your IP Address 
bind-address        = xxx.xxx.xxx.xxx
```


create user
```
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypass';
CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypass';
```

grant

```
GRANT ALL ON *.* TO 'myuser'@'localhost';
GRANT ALL ON *.* TO 'myuser'@'%';


mysql> GRANT ALL PRIVILEGES ON *.* TO 'USERNAME'@'%' IDENTIFIED BY 'PASSWORD' WITH GRANT OPTION;
```




```
mysql> create database databasename;
Query OK, 1 row affected (0.00 sec)
mysql> grant all on databasename.* to cmsuser@localhost identified by 'password';
Query OK, 0 rows affected (0.00 sec)
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
```



```
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'm117988' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```


https://rtcamp.com/tutorials/mysql/remote-access/

http://www.cyberciti.biz/tips/how-do-i-enable-remote-access-to-mysql-database-server.html
