## change the author of a commit in git




#### remove big file in git file

```ruby
git filter-branch --index-filter \   
        'find -name ''*.mp3'' -or -name ''*.ogg'' | xargs -d''\n'' rm -f'  
  
#Suppose you want to remove a file (containing confidential information or copyright violation) from all commits:  
  
git filter-branch --tree-filter 'rm filename' HEAD  
```
