## some tmux usage


```ruby
tmux new -s demo

tmux attach -t demo

Ctrl + b  && d #exit

Ctrl + b && %  #split

```

more usage


```ruby
^b , <newname> # rename current session
^b w  #list windows
^b #  #goto windows #
^b l  #goto last window
^b n  #goto next window
^b p  #goto previous window
^b s  #list sessions

^b c  #create another shell/window
^d    #exit current shell
^b "  #split panel horizontally
^b %  #split panel vertically
^b o  #switch to another panel
^b x || ^d #kill the current panel
^b !  #kill other panel except the current one

^b ^o #swap location of the panel
^b t  #show time
^b q  #show numeric values of panel



```



