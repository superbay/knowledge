
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

