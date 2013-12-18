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


### alias version 1

```ruby

# ~/.aliases
# Record how much I've used various Git commands:
#   http://github.com/icefox/git-achievements
alias git="git-achievements"

# Working with Git
alias g='git'
alias gs='git status'
alias gc='git commit'
alias gca='git commit -a'
alias ga='git add'
alias gco='git checkout'
alias gb='git branch'
alias gm='git merge'
alias gd="git diff"

# Working with Rails
alias s='script/server'
alias c='script/console'
alias m='rake db:migrate'
alias r='rake'

# Open the current directory in TextMate
alias e='mate .'

# Serve the contents of the current directory over HTTP
alias serve="ruby -rwebrick -e\"s = WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start\""
Now source the aliases file from your ~/.profile to use them.

# ~/.profile
for I in aliases; do
  [ -f ~/.$I ] && . ~/.$I
done
```







