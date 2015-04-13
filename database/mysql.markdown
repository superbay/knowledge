
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
```




```
mysql> create database databasename;
Query OK, 1 row affected (0.00 sec)
mysql> grant all on databasename.* to cmsuser@localhost identified by 'password';
Query OK, 0 rows affected (0.00 sec)
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
```

