### find and exclude all permission denied message


like this

```
find: /./proc/1731/fdinfo: Permission denied
find: /./proc/2032/task/2032/fd: Permission denied
```

Those errors are printed out to the standard error output (fd 2). To filter them out, simply redirect all errors to /dev/null:

```bash
find . 2>/dev/null > some_file
```


or first join stderr and stdout and then grep out those specific errors:

````bash
find . 2>&1 | grep -v 'Permission denied' > some_file
```



### search all file and all content



```

find . -name \*.* | xargs grep 'GMAT'

```

pay more attion about the '\'


### search all files and replace

```ruby
#Remove FactoryGirl.
find . -type f -name *_spec.rb -print | xargs  sed -ie 's/FactoryGirl\.//g'

```


```ruby
#Seems like Linux is being far too generous.

-i 's/^[[:space:]]\{11\}//g' <-- makes it look like 
"s/^[[:space:]]\{11\}//g" is the extension given to "-i"

#baf's quotes serve to clarify to the interpreter (and to humans reading it) that
there is no extension. hayne's -e is also a means with which to disambiguate.

#Thus, these all work:
sed -i "" 's/^[[:space:]]\{11\}//g' menu1a.sh 
sed -i -e 's/^[[:space:]]\{11\}//g' menu1a.sh 
sed -ie 's/^[[:space:]]\{11\}//g' menu1a.sh 
sed -i "" -e 's/^[[:space:]]\{11\}//g' menu1a.sh

#Makes sense.

```


### 

```ruby
#find and delete .svn
find . -type d -name ".svn"|xargs rm -rf
```
