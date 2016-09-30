### List Git commits not pushed to the origin yet

or 

### Viewing Unpushed Git Commits



```
git log origin/master..master
```

or, more generally:

```
git log <since>..<until>
```

You can use this with grep to check for a specific, known commit:

```
git log <since>..<until> | grep <commit-hash>
```

Or you can also use git-rev-list to search for a specific commit:

```
git rev-list origin/master | grep <commit-hash>
```



### git search log from merge commits

```
git log -m -S 'search_term' app/models/path_file.rb
```


[reference](http://stackoverflow.com/questions/2016901/viewing-unpushed-git-commits)

