Given some data like the following:
```
one	first example
two	second example
three	third example
four	fourth example
```

suppose you want to change the data to make a dictionary for a Python program, with this result:

```ruby
data = {
    'one': 'first example',
    'two': 'second example',
    'three': 'third example',
    'four': 'fourth example',
}
```

To do this, record a macro while changing the first line. Then, playback the macro to change each other line. When finished, manually insert the initial "data = {" line, and the final "}" line.

The following shows one way to record a suitable macro.

Put the cursor on the first line.
* Type `qd` (the q starts recording; the `d` is the register where keys will be recorded).
* Type the following command to change the first sequence of whitespace to "': '":

```
`:s/\s\+/': ' (then press Enter)`
```

* Type the following to insert four spaces followed by "'" at the start of the line:

```
I    ' (then press Escape)
```

* Type the following to append "'," to the line:

```
A', (then press Escape)
```

* Type the following to move the cursor to the start of the line, then down to the next line:

```
0j
```

* Type q to stop recording the macro.

The cursor should now be on the second line. Type @d to playback the macro once. That should change the second line, with the cursor finishing on the third line. Type 2@@ to finish. The 2 means that what follows is performed twice, and the @@ plays back the last used macro. Instead of 2@@, you could type @d or @@ twice.
