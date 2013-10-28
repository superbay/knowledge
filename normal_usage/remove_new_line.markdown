## Remove ^M


```ruby
#vim  
:set fileformat=unix  
:%s/^M//g  
:%s/\r//g  
```

other tools

```ruby

sed s/\r// hello.txt > helloUNIX.txt  
dos2unix hello.txt helloUNIX.txt  
cat hello.txt | tr -d \r > helloUNIX2.txt  

```
