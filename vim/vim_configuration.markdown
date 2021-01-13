### how to install new dotvimv2


### how to install cmake for amazon linux 2
Amazon has a guide: Preparing to Compile Software, which proposes the following command to install a C compiler.
```
sudo yum groupinstall "Development Tools"
```
Next, you can download and build Cmake yourself: Install Cmake 3.
```
wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz
tar -xvzf cmake-3.18.0.tar.gz
cd cmake-3.18.0
./bootstrap
make
sudo make install
```
Note: the last make actually needs sudo.


```ruby
export EDITOR='vim'
echo "export EDITOR='vim'" >> ~/.profile

export EDITOR='vim'
export VISUAL='vim'

```

set vim soft tab to be 2 spaces

```ruby
set tabstop=2 shiftwidth=2 expandtab
```



```ruby
#.vimrc.after
colorscheme vividchalk
set wrap
set paste
```
