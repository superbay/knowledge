### About the alias && shortcut

```ruby

git config user.email "ke@me.com"  

```

#### git default editor

```ruby
git config --global core.editor "vim"
or set the VISUAL or EDITOR environment variables.

export VISUAL=vim
export EDITOR=vim
```


#### different between .bash_rc .bash_profile in ubuntu and mac

add link [here](#) later


#### terminal color

```ruby
#.bash_profile 
export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad
```

### setup git branch promote


### git config
```ruby
#~/.gitconfig
[user]
  name = Phoenix
  email = phoenixtoday@gmail.com
[alias]
  co = checkout
  ci = commit -a
  st = status
  br = branch
  oneline = log --pretty=oneline --since='2 days ago'
  onelog = log -p -1
[color]
  diff = auto
  status = auto
  branch = auto
  ui = auto
[core]
  editor = vim
```







