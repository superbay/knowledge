#### check current linux version

```bash
cat /etc/issue
#or
cat /etc/issue.net

```

#### check particular lib version

```bash
ldconfig -v | grep -i mysql

```


### git branch prompt


```bash
# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
```
