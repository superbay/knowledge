:%s/foo/bar/

On each line, replace the first occurrence of "foo" with "bar".

:%s/.*\zsfoo/bar/

On each line, replace the last occurrence of "foo" with "bar".

:%s/\<foo\>//g

On each line, delete all occurrences of the whole word "foo".

:%s/\<foo\>.*//

On each line, delete the whole word "foo" and all following text (to end of line).

:%s/\<foo\>.\{5}//

On each line, delete the first occurrence of the whole word "foo" and the following five characters.

:%s/\<foo\>\zs.*//

On each line, delete all text following the whole word "foo" (to end of line).

:%s/.*\<foo\>//

On each line, delete the whole word "foo" and all preceding text (from beginning of line).

:%s/.*\ze\<foo\>//

On each line, delete all the text preceding the whole word "foo" (from beginning of line).

:%s/.*\(\<foo\>\).*/\1/

On each line, delete all the text preceding and following the whole word "foo".

:s/^\(\w\)/\u\1/

If the first character at the beginning of the current line is lowercase, switch it to uppercase using \u (see switching case of characters).

:%s/\(.*\n\)\{5\}/&\r/

Insert a blank line every 5 lines.

The pattern searches for \(.*\n\) (any line including its line ending) repeated five times (\{5\}).

The replacement is & (the text that was found), followed by \r (newline).

:%s/\<foo\(\a*\)\>/\=len(add(list, submatch(1)))?submatch(0):submatch(0)/g

Get a list of search results. (the list must be exists)

Indicates the modified flag, because of the replacement, but the content is unchanged.
Note: With a recent enough Vim (version 7.3.627 or higher), you can simplify this to:

:%s/\<foo\(\a*\)\>/\=add(list, submatch(1))/gn

This has the advantage, that the buffer won't be marked modified and no extra undo state is created. The expression in the replacement part is executed in the sandbox and not allowed to modify the buffer.
