clear session

```
ERROR LOG

` ArgumentError in Scoring#index

Showing app/views/scoring/index.html.erb where line #4 raised:

marshal data too short

```


solved by running:


```
rake tmp:clear                                      
# Clear session, cache, and socket files from tmp/ (narrow w/ tmp:sessions:clear, tmp:cache:clear, tmp:sockets:clear)

```
