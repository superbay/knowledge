### arc diff

```ruby
arc diff HEAD^
```

### update your change 

```ruby
arc diff HEAD^ --preview
```

### while some one accept

```ruby
arc land --revision D2423 --hold --onto master
```
revision is the number of your review 
hold will not push
onto will be the branch it merge
and it also delete the current branch

```ruby
`git checkout -b 'sponsor' '1dbab27e1cd866a1f508917505d8d81603621e97'`
```
