### Brew install postgresql



Postgresql version: 9.3.2

```ruby
#Steps to install and run PostgreSQL 9.2 using Homebrew (Mac OS X)
#(if you aren't using version 9.1.5, change line 6 with the correct version)
 
1. launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
2. mv /usr/local/var/postgres /usr/local/var/postgres91
3. brew update
4. brew upgrade postgresql
5. initdb /usr/local/var/postgres -E utf8
6. pg_upgrade -b /usr/local/Cellar/postgresql/9.1.5/bin -B /usr/local/Cellar/postgresql/9.2.0/bin -d /usr/local/var/postgres91 -D /usr/local/var/postgres
7. cp /usr/local/Cellar/postgresql/9.2.0/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
8. pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
 
#If you're using ruby, also:
 
gem pristine pg

```
