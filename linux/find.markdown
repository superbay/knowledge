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


search and add

```
find . -type f -name "*.py" -exec sh -c 'cat somecode.txt >> "$1"' -- {} \;
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


#### find and sort by modify date

```
find -type f -printf '%T@ %p\0' |
sort -zk 1nr |
sed -z 's/^[^ ]* //' | tr '\0' '\n' | head -n 10
```


```
find . -printf "%T@ %Tc %p\n" | sort -n
find . your-options -printf "%T+\t%p\n" | sort

printf arguments from man find:

%Tk: File's last modification time in the format specified by k.
@: seconds since Jan. 1, 1970, 00:00 GMT, with fractional part.
c: locale's date and time (Sat Nov 04 12:02:33 EST 1989).
%p: File's name.
```



```
man ls:
-t     sort by modification time
-r,    reverse order while sorting (--reverse )
-1     list one file per line

find /wherever/your/files/hide -type f -exec ls -1rt "{}" +;
```


```
find . -type f -printf "%T@\t%Tc %6k KiB %p\n" | sort -n | cut -f 2-
```


for mac
```
find . -type f -ls | awk '{print $(NF-3), $(NF-2), $(NF-1), $NF}' | sort
```

```
#With timestamp:
find . -type f -exec stat -f "%Sm %N" -t "%Y%y%m%d%H%M" {} \; | sort -r
#Without timestamp:
find . -type f -exec stat -f "%Sm %N" -t "%Y%y%m%d%H%M" {} \; | sort -r | awk -F' ' '{ print substr($0, length($1) + 2) }'
```


#### find and sort by 

```
find . -name "*.ear" -exec du -a {} \;
$ find . -name "test*" -exec du -sh {} \;
find . -type f -iname "*.ear" -exec du -ah {} \; | awk '{print $2"\t", $1}'

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
