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

### find the top 10 large file



```ruby
du -ah . | sort -n -r | head -n 10
## Warning: only works with GNU find ##
find /path/to/dir/ -printf '%s %p\n'| sort -nr | head -10
find . -printf '%s %p\n'| sort -nr | head -10

#You can skip directories and only display files, type:

 
find /path/to/search/ -type f -printf '%s %p\n'| sort -nr | head -10
 
#OR

 
find /path/to/search/ -type f -iname "*.mp4" -printf '%s %p\n'| sort -nr | head -10
 


```

like this version

works well to help with find the largest file or folder, fast and easy

```ruby
du -sh `ls .` 
```



#### find and rename

```
find . -name "*.andnav" | rename "s/\.andnav$/.tile/"
```

At least on Ubuntu derivations rename takes a list of files from STDIN if none are on the command line. And this can be tested easily with:
```
find . -name "*.andnav" | rename -vn "s/\.andnav$/.tile/"
```


### zip

```
 mkdir -p playground/dir-{00{1..9},0{10..99},100} 

 touch playground/dir-{00{1..9},0{10..99},100}/file-{A-Z}

 find playground -name 'file-A' | tar czf playground.tgz -T -
 
 find playground -name 'file-A' | tar cf - --files-from=- | gzip > playground.tgz
 
 
```


```
#Quercus_laceyi.shp_poly
#to
#Quercus_laceyi_poly.shp
for i in ` find /root/test/ -name "*.shp" ` ;
do
  mv $i ` echo $i | sed 's/.shp$/_poly.shp/g' ` ;
done
```
