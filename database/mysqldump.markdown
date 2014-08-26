### mysqldump


```ruby
mysqldump -u root -p -t reptile usings -w "down_time = '2010-06-04'" > backup_using.sql -t -w 
```

#### remote dump

```ruby

  mysqldump -P 3310 -h localhost -u mysql_user -p database_name table_name

```





#### 备份数据库 

```
#mysqldump 数据库名 >数据库备份名  
  
#mysqldump -A -u用户名 -p密码 数据库名>数据库备份名  
  
#mysqldump -d -A --add-drop-table -uroot -p >xxx.sql  
```



1.导出结构不导出数据 

```
mysqldump --opt -d 数据库名 -u root -p > xxx.sql  
```

2.导出数据不导出结构 

```
mysqldump -t 数据库名 -uroot -p > xxx.sql  
```

3.导出数据和表结构 

```
mysqldump 数据库名 -uroot -p > xxx.sql  
```

4.导出特定表的结构 
```
mysqldump -uroot -p -B数据库名 --table 表名 > xxx.sql  
```

#### 导入数据： 

由于mysqldump导出的是完整的SQL语句，所以用mysql客户程序很容易就能把数据导入了： 

```
#mysql 数据库名 < 文件名  
#source /tmp/xxx.sql  

```  



