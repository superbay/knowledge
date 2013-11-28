### unicorn start && stop


```bash
unicorn_rails -c config/unicorn.rb -D -E production
ps aux | grep unicorn | awk '{print $2}' | xargs kill -s 9
```
