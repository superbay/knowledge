```ruby
git grep 'time_t' -- '*.[ch]'
#Looks for time_t in all tracked .c and .h files in the working directory and its subdirectories.

git grep -e '#define' --and \( -e MAX_PATH -e PATH_MAX \)
#Looks for a line that has #define and either MAX_PATH or PATH_MAX.

git grep --all-match -e NODE -e Unexpected
#Looks for a line that has NODE or Unexpected in files that have lines that match both.
```
