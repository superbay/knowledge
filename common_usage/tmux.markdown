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
^b &  #kill current window/session
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

[cheat sheet gist](https://gist.github.com/henrik/1967800)


# tmux cheatsheet

As configured in [my dotfiles](https://github.com/henrik/dotfiles/blob/master/tmux.conf).

start new:

    tmux

start new with session name:

    tmux new -s myname

attach:

    tmux a  #  (or at, or attach)

attach to named:

    tmux a -t myname

list sessions:

    tmux ls

kill session:

    tmux kill-session -t myname

In tmux, hit the prefix `ctrl+b` and then:

## Sessions

    :new<CR>  new session
    s  list sessions
    $  name session

## Windows (tabs)

    c           new window
    ,           name window
    w           list windows
    f           find window
    &           kill window
    .           move window - prompted for a new number
    :movew<CR>  move window to the next unused number

## Panes (splits)

    %  horizontal split
    "  vertical split
    
    o  swap panes
    q  show pane numbers
    x  kill pane
    ⍽  space - toggle between layouts

## Window/pane surgery

    :joinp -s :2<CR>  move window 2 into a new pane in the current window
    :joinp -t :1<CR>  move the current pane into a new pane in window 1

* [Move window to pane](http://unix.stackexchange.com/questions/14300/tmux-move-window-to-pane)
* [How to reorder windows](http://superuser.com/questions/343572/tmux-how-do-i-reorder-my-windows)

## Misc

    d  detach
    t  big clock
    ?  list shortcuts
    :  prompt

Resources:

* [cheat sheet](http://cheat.errtheblog.com/s/tmux/)



<kbd>⌘</kbd>+<kbd>⌥</kbd>+<kbd>←</kbd>/<kbd>↑</kbd>/<kbd>→</kbd>/<kbd>↓</kbd> will let you navigate split panes in the direction of the arrow, i.e. when using <kbd>⌘</kbd>+<kbd>D</kbd> to split panes vertically, <kbd>⌘</kbd>+<kbd>⌥</kbd>+<kbd>←</kbd> and <kbd>⌘</kbd>+<kbd>⌥</kbd>+<kbd>→</kbd> will let you switch between the panes. 




