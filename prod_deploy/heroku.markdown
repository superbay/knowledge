### database.yml




### while push get Permission denied error

```
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
```

solution

```ruby
#You have to upload your public key to Heroku:

heroku keys:add ~/.ssh/id_rsa.pub
#If you don't have a public key, Heroku will prompt you to add one automatically which works seamlessly. Just use:

heroku keys:add
```


### reset database

```
heroku pg:reset DATABASE_URL --confirm {the name of your app}

```
