
## How to test interactive ruby program


```ruby
while (print "> "; input = gets) do
  input.chomp!
  case input
  when "quit" then break
  else puts input.upcase + "!"
  end
end
```

### pipe 

```ruby
pipe = open("|ruby shout.rb", File::RDWR|File::NONBLOCK)
pipe.read                       # =>

pipe = open("|ruby shout.rb", File::RDWR|File::NONBLOCK)
pipe.close_write
pipe.read                       # => "> "

```
Only after we close the “write” end of the pipe can we read anything out of it.
I believe this behavior is related to pipe buffering, which can be difficult to control.

### PTY

On UNIX-like operating systems, it’s possible to create something called a pseudo-terminal, or PTY. A PTY is just like a real terminal from the point of view of a process running inside it. It just isn’t connected to any terminal window.

```ruby
require "pty"
r, w, pid = PTY.spawn("ruby shout.rb")
 
r.getc                          # => ">"
r.getc                          # => " "
```
read non block

```ruby
require "pty"
r, w, pid = PTY.spawn("ruby shout.rb")
 
w.write "hello\n"
r.read_nonblock(1024)           # => "hello\r\n"
r.read_nonblock(1024)           # => IO::EAGAINWaitReadable: Resource tempora...
 
# ~> IO::EAGAINWaitReadable
# ~> Resource temporarily unavailable - read would block
# ~>
# ~> xmptmp-in6109_Yd.rb:6:in `read_nonblock'
# ~> xmptmp-in6109_Yd.rb:6:in `<main>'
```


```ruby
require "pty"
r, w, pid = PTY.spawn("ruby shout.rb")
 
w.write "hello\n"
r.read_nonblock(1024)           # => "hello\r\n"
sleep 0.1
r.read_nonblock(1024)           # => "> HELLO!\r\n> "
```

### expect gem

```ruby
require "pty"
require "expect"
 
r, w, pid = PTY.spawn("ruby shout.rb")
 
r.expect("> ")                   # => ["> "]
```


```ruby
require "pty"
require "expect"
 
r, w, pid = PTY.spawn("ruby shout.rb")
 
r.expect(/\>/)                  # => [">"]
w.write("hello\n")
r.expect(/HELLO!/)              # => [" hello\r\nHELLO!"]
```


```ruby
require "pty"
require "expect"
 
r, w, pid = PTY.spawn("ruby shout.rb")
 
r.expect("heffalump", 1)        # => nil
```


### final solution

```ruby
require "pty"
require "expect"
 
r, w, pid = PTY.spawn("ruby shout.rb")
r.expect("> ")                  # => ["> "]
w.write("hello\n")
r.expect(/HELLO!/)              # => ["hello\r\nHELLO!"]
r.expect("> ")                  # => ["\r\n> "]
w.write("quit\n")
pid, status = Process.waitpid2(pid)
status                          # => #<Process::Status: pid 23466 exit 0>
status.success?                 # => true
```
