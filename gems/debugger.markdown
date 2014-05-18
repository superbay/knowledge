https://github.com/pat/thinking-sphinx

please use byebug to replace debugger

https://github.com/deivid-rodriguez/byebug

### problem with install debugger-linecache




```ruby
gem install ruby-debug19 -- --with-ruby-include=$rvm_path/src/ruby-1.9.2-head/
  gem install ruby-debug19 -- --with-ruby-include=$rvm_path/src/ruby-1.9.3-p545/
  gem install debugger-linecache -v '1.1.2' -- --with-ruby-include=$rvm_path/src/ruby-1.9.3-p545/

```


error message:


```


Building native extensions.  This could take a while...
ERROR:  Error installing ruby-debug19:
 ERROR: Failed to build gem native extension.

/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/bin/ruby extconf.rb
checking for rb_method_entry_t.body in method.h... no
checking for vm_core.h... no
checking for rb_method_entry_t.body in method.h... no
checking for vm_core.h... yes
checking for iseq.h... yes
checking for insns.inc... yes
checking for insns_info.inc... yes
checking for eval_intern.h... yes
creating Makefile

make
gcc -I. -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1/i386-darwin10.4.0 -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1/ruby/backward -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1 -I. -DHAVE_VM_CORE_H -DHAVE_ISEQ_H -DHAVE_INSNS_INC -DHAVE_INSNS_INFO_INC -DHAVE_EVAL_INTERN_H -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1/ruby-1.9.1-p378 -fno-common  -O2 -g -Wall -Wno-parentheses  -fno-common -pipe -fno-common  -o breakpoint.o -c breakpoint.c
gcc -I. -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1/i386-darwin10.4.0 -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1/ruby/backward -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1 -I. -DHAVE_VM_CORE_H -DHAVE_ISEQ_H -DHAVE_INSNS_INC -DHAVE_INSNS_INFO_INC -DHAVE_EVAL_INTERN_H -I/Users/benjohnson/.rvm/rubies/ruby-1.9.1-p378/include/ruby-1.9.1/ruby-1.9.1-p378 -fno-common  -O2 -g -Wall -Wno-parentheses  -fno-common -pipe -fno-common  -o ruby_debug.o -c ruby_debug.c
ruby_debug.c: In function ‘ruby_method_ptr’:
ruby_debug.c:141: error: ‘rb_method_entry_t’ undeclared (first use in this function)
ruby_debug.c:141: error: (Each undeclared identifier is reported only once
ruby_debug.c:141: error: for each function it appears in.)
ruby_debug.c:141: error: ‘method’ undeclared (first use in this function)
ruby_debug.c:142: warning: implicit declaration of function ‘rb_method_entry’
ruby_debug.c: In function ‘debug_event_hook’:
ruby_debug.c:719: error: ‘rb_method_entry_t’ undeclared (first use in this function)
ruby_debug.c:719: error: ‘me’ undeclared (first use in this function)
make: *** [ruby_debug.o] Error 1


Gem files will remain installed in /Users/benjohnson/.rvm/gems/ruby-1.9.1-p378/gems/ruby-debug-base19-0.11.24 for inspection.
Results logged to /Users/benjohnson/.rvm/gems/ruby-1.9.1-p378/gems/ruby-debug-base19-0.11.24/ext/ruby_debug/gem_make.out
```
