## change the author of a commit in git

#### Change all commits information

```ruby

git filter-branch -f --env-filter "GIT_AUTHOR_NAME='Newname'; GIT_AUTHOR_EMAIL='newemail'; GIT_COMMITTER_NAME='Newname'; GIT_COMMITTER_EMAIL='newemail';" HEAD


git filter-branch -f --env-filter "
    GIT_AUTHOR_DATE='Fri Jan 2 21:38:53 2009 -0800'
    GIT_COMMITTER_DATE='Sat May 19 01:01:01 2007 -0700'
    GIT_AUTHOR_NAME='Newname'
    GIT_AUTHOR_EMAIL='newemail'
    GIT_COMMITTER_NAME='Newname'
    GIT_COMMITTER_EMAIL='newemail'
  " HEAD

```


#### Change particular commit information

```ruby
git filter-branch --commit-filter '  
        if [ "$GIT_COMMITTER_NAME" = "<Old Name>" ];  
        then  
                GIT_COMMITTER_NAME="<New Name>";  
                GIT_AUTHOR_NAME="<New Name>";  
                GIT_COMMITTER_EMAIL="<New Email>";  
                GIT_AUTHOR_EMAIL="<New Email>";  
                git commit-tree "$@";  
        else  
                git commit-tree "$@";  
        fi' HEAD 
```

#### remove big file in git file

```ruby
git filter-branch --index-filter \   
        'find -name ''*.mp3'' -or -name ''*.ogg'' | xargs -d''\n'' rm -f'  
  
#Suppose you want to remove a file (containing confidential information or copyright violation) from all commits:  
  
git filter-branch --tree-filter 'rm filename' HEAD  
```

#### find and remove

```ruby
find . -name *.DS_Store -type f -exec git-rm {} \;
```


### git commit with different user

```
git commit --author="Name <email>" -m "whatever"
```


### only update the commit date



```
GIT_COMMITTER_DATE="`date`" git commit --amend --date "`date`"


git commit --amend --date "Thu May 28 18:21:46 2015 +0530"
```
