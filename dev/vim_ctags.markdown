### VIM ctags setup ack

#### reindex rbenv

```bash
ctags --extra=+f --exclude=.git --exclude=log --exclude=coverage --exclude=public/assets -R *  /home/ken/.rbenv/versions/1.9.3-p429/lib/ruby/gems/1.9.1/gems/*
```
