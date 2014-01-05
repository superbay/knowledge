### VIM ctags setup ack

#### reindex rbenv

```bash
ctags --extra=+f --exclude=.git --exclude=log --exclude=coverage --exclude=public/assets -R *  /home/ken/.rbenv/versions/1.9.3-p429/lib/ruby/gems/1.9.1/gems/*
```

#### reindex rvm

```bash
ctags --extra=+f --exclude=.git --exclude=log --exclude=coverage --exclude=public/assets -R * `rvm gemdir`/gems/*
```

#### ubuntu wrong ack

```bash
sudo ln -s /usr/bin/ack-grep /usr/local/bin/ack  
```


[origin_link](http://hlee.iteye.com/blog/1488865)


#### Mac error about link

```
:!ctags -R .
ctags: illegal option -- R
usage: ctags [-BFadtuwvx] [-f tagsfile] file ...

```

The solution:

```

brew install ctags

which ctags
#/usr/bin/

> PATH=/usr/local/bin:$PATH
> which ctags
#/usr/local/bin
```

ubuntu install as

```ruby
sudo aptitude install exuberant-ctags  
```

or


```
set fileformat=unix  
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'  
```

[ctags reference](http://blog.stwrt.ca/2012/10/31/vim-ctags)


