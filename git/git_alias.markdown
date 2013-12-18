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


#### alias version 2

```ruby
#Top ten commands
function t10 {
	history |
		awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' |
		sort -rn |
		head
}

# processes
alias tu="top -o cpu"
alias tm="top -o vsize"

# Git
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit -v"
alias gd="git diff | mate"
alias gl="git pull"
alias gp="git push"
alias gst="git status"
alias gco='git checkout'

# Ruby
# Quicker cd gems directory
alias cg='cd /usr/local/lib/ruby/gems/1.8/gems'
alias cg19='cd /usr/local/lib/ruby19/gems/1.9.1/gems'


# Rails
alias ss="script/server"
alias ss19="ruby19 script/server"
alias sc="script/console"
alias sc19="script/console --irb=irb19"
alias sg="script/generate"
alias sg19="ruby19 script/generate"

alias r="rake"
alias r19="rake19"
alias rmig="rake db:migrate"
alias rmig19="rake19 db:migrate"
alias rt="ruby -Itest"
alias rt19="ruby19 -Itest"

alias cs="RAILS_ENV=selenium cucumber -p selenium"
alias pgrep="ps -ef | grep $1"

source /usr/local/git/contrib/completion/git-completion.bash
PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h\[\033[33m\w$(__git_ps1 " (%s)")\033[0m\]\n$'

```


#### other git config

```ruby
git config --global user.name "Tsung"
git config --global user.email "username@email.com"
git config --global color.diff auto # git diff 要顯示顏色
git config --global color.status auto # git status 要顯示顏色
git config --global color.branch auto
```






