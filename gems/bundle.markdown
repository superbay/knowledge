### install nokogiri


To fix this if you're using homebrew and bundler, add gem 'nokogiri' to the top of your Gemfile, then run these commands:
```
gem uninstall nokogiri libxml-ruby
brew update
brew uninstall libxml2
brew install libxml2 --with-xml2-config
brew install libxslt
bundle config build.nokogiri --with-xml2-include=/usr/local/Cellar/libxml2/2.9.1/include/libxml2 --with-xml2-lib=/usr/local/Cellar/libxml2/2.9.1/lib --with-xslt-dir=/usr/local/Cellar/libxslt/1.1.26/
bundle install
```

If you don't use bundler, run these commands instead:

```
gem uninstall nokogiri libxml-ruby
brew update
brew uninstall libxml2
brew install libxml2 --with-xml2-config
brew install libxslt
gem install nokogiri -- --with-xml2-include=/usr/local/Cellar/libxml2/2.9.1/include/libxml2 --with-xml2-lib=/usr/local/Cellar/libxml2/2.9.1/lib --with-xslt-dir=/usr/local/Cellar/libxslt/1.1.26/
```
In your app, you should require nokogiri first, to force the app to load the dynamic libxml2 library instead of the older system version of libxml2 loaded by gems that failed to specify which library to load.

```
bundle config build.nokogiri --with-xml2-include=/sw/include/libxml2 --with-xml2-lib=/sw/lib --with-xslt-dir=/sw
```

```
bundle config build.nokogiri "--use-system-libraries --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include/libxml2

bundle install
```



### Gem install pg works but bundle install fails

check which `bundle` and which `gem`

```
bundle config build.pg --with-pg-config=/path/to/pg_config
bundle config build.pg --with-pg-include=/usr/pgsql-9.3/include --with-pg-dir=/usr/pgsql-9.3
bundle install

```



### uninstall mongodb 

```
#!/usr/bin/env sh
 
# checks to see if running 
launchctl list | grep mongo
 
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
launchctl remove homebrew.mxcl.mongodb
 
pkill -f mongod
 
rm -f ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
 
brew uninstall mongodb
 
# double check existence
ls -al /usr/local/bin/mong*
ls -al ~/Library/LaunchAgents
```
