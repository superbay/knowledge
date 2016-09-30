```ruby
git grep 'time_t' -- '*.[ch]'
#Looks for time_t in all tracked .c and .h files in the working directory and its subdirectories.

git grep -e '#define' --and \( -e MAX_PATH -e PATH_MAX \)
#Looks for a line that has #define and either MAX_PATH or PATH_MAX.

git grep --all-match -e NODE -e Unexpected
#Looks for a line that has NODE or Unexpected in files that have lines that match both.
```

[reference1](http://travisjeffery.com/b/2012/02/search-a-git-repo-like-a-ninja/)<br/>
[reference2](https://www.kernel.org/pub/software/scm/git/docs/git-grep.html)


### Regular Expression


```
git grep -E 'plan.{1}years-list' 
```

### git log --grep 

```
git log --grep=frotz --grep=nitfol --since=1.month
git log --grep=frotz --and --author=Linus
```

### git search log from merge commits

```
git log -m -S 'search_term' app/models/path_file.rb
```
