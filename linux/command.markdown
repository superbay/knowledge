### tee


```
tee [OPTION]... [FILE]...

-a
--append	Append to the given FILEs, do not overwrite.
-i	ignore interrupt signals.
--help	Display the help screen.
--version	Display the version.
```

Examples

```
ls *.txt | wc -l | tee /dev/tty count.txt
```

In the above example, the ls command would list all .txt files in the current directory, take a word count (wc) by the amount of lines (-l) and the output displayed to the /dev/tty (terminal) will be sent to the count.txt.

Note: Because the above example did not take advantage of the -a (append option) if the count.txt file already existed it would have been overwritten.
