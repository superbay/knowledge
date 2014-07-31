### SSH login without password

```

cat .ssh/id_rsa.pub | ssh b@B 'cat >> .ssh/authorized_keys'

```

[reference](http://www.linuxproblem.org/art_9.html)

## tee


```
tee [OPTION]... [FILE]...

-a
--append	Append to the given FILEs, do not overwrite.
-i	ignore interrupt signals.
--help	Display the help screen.
--version	Display the version.
```

#### Examples

```
ls *.txt | wc -l | tee /dev/tty count.txt
```

In the above example, the ls command would list all .txt files in the current directory, take a word count (wc) by the amount of lines (-l) and the output displayed to the /dev/tty (terminal) will be sent to the count.txt.

Note: Because the above example did not take advantage of the -a (append option) if the count.txt file already existed it would have been overwritten.


#### Example 2: Write the output to two commands

You can also use tee command to store the output of a command to a file and redirect the same output as an input to another command.

The following command will take a backup of the crontab entries, and pass the crontab entries as an input to sed command which will do the substituion. After the substitution, it will be added as a new cron job.

```
$ crontab -l | tee crontab-backup.txt | sed 's/old/new/' | crontab –
```
