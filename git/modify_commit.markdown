## change the author of a commit in git


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
