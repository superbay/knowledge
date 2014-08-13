
Vim provides the :s (substitute) command for search and replace; this tip shows examples of how to substitute. 


[references](http://vim.wikia.com/wiki/Search_and_replace)

### count how many lines, match that pattern


```ruby
:%s/pattern//gn
```

```
#all lines
:%s/foo/bar/g
```

Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.

```
#current line only
:s/foo/bar/g
```

Find each occurrence of 'foo' (in the current line only), and replace it with 'bar'.




### Delete all lines containing a pattern

The ex command g is very useful for acting on lines that match a pattern. You can use it with the d command, to delete all lines that contain a particular pattern, or all lines that do not contain a pattern.
For example, to delete all lines containing "profile" (the first command is optional; it shows the lines that the second command will delete):

```
:g/profile
:g/profile/d
```

More complex patterns can be used, such as deleting all lines that are empty or that contain only whitespace:

```
:g/^\s*$/d
```

To delete all lines that do not contain a pattern, use g!, like this command to delete all lines that are not comment lines in a Vim script:
```
:g!/^\s*"/d
```
Note that g! is equivalent to v, so you could also do the above with:
```
:v/^\s*"/d
```

The next example shows use of \| ("or") to delete all lines except those that contain "error" or "warn" or "fail" (:help pattern):

```
:v/error\|warn\|fail/d

```



