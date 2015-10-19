## Remove ^M


```ruby
#vim  
:set fileformat=unix  
:%s/^M//g  
:%s/\r//g  
```


### change ^M to new line


```ruby
:%s/<Ctrl-V><Ctrl-M>/\r/g
```

Where <Ctrl-V><Ctrl-M> means type Ctrl+V then Ctrl+M. 


sometimes

On Linux and Mac OS, the following works,

```ruby
:%s/^V^M/^V^M/g
```



other tools

```ruby

sed s/\r// hello.txt > helloUNIX.txt  
dos2unix hello.txt helloUNIX.txt  
cat hello.txt | tr -d \r > helloUNIX2.txt  

```
