#### Why Postgresql more popular? (2013)


PostgreSQL is a lot more advanced when it comes to SQL features.

Things that MySQL still doesn't have (and PostgreSQL has):


```


deferrable constraints
check constraints
full outer join
regular expressions don't work with UTF-8
table functions ( select * from my_function() )
common table expressions
recursive queries (using common table expressions)
windowing functions
function based index
partial index
full text search on transactional tables (MySQL 5.6 supports this now as well)
GIS features on transactional tables
MINUS or INTERSECT operator
you cannot use a temporary table twice in the same select statement
you cannot use the table being changed (update/delete/insert) in a sub-select
transactional DDL
roles (groups) to manage user privileges
```

[reference](http://stackoverflow.com/questions/8181604/postgres-9-1-vs-mysql-5-6-innodb)
[reference2](http://readwrite.com/2013/09/10/postresql-hits-93-new-levels-of-popularity-with-the-cool-kids#awesm=~opj1dkkrUEzbMD)
