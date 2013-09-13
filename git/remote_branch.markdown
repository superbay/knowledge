### reset to remote branch

```
git fetch origin
git reset --hard origin/feature/annotations
```


#### pull from remote branch

```
git pull origin refs/heads/feature/annotations

```


#### add and delete remote tag

```ruby
git push origin head:newbranch_name 
git push origin head:feature/newbranch_name   

#删除远程分支，其它开发者要git branch －d －r 分支  
git push origin :newbranch_name  

```
