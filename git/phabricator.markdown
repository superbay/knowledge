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

### arc land to feature branch

make sure below issue done, before arc land

```bash
branch.develop.remote=origin
branch.develop.merge=refs/heads/develop
branch.feature/quiz.remote=origin
branch.feature/quiz.merge=refs/heads/feature/quiz

#If you often merge with the same branch, you may want to
#use something like the following in your configuration file:

    [branch "feature/quiz"]
    remote = <nickname>
    merge = <remote-ref>

    [remote "<nickname>"]
    url = <url>
    fetch = <refspec>

#See git-config(1) for details.
```


```ruby
`git checkout -b 'sponsor' '1dbab27e1cd866a1f508917505d8d81603621e97'`
```
