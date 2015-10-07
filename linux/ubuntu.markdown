

### mint linux 17 install chrome


1. Open a terminal window.

2. Type in the following commands then hit Enter after each:

For 32-bit Chrome:

```

wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb

sudo gdebi google-chrome-stable_current_i386.deb

```


For 64-bit Chrome:

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo gdebi google-chrome-stable_current_amd64.deb

```


### install google pinyin

```

sudo apt-get install im-switch fcitx fcitx-config-gtk2 fcitx-googlepinyin fcitx-frontend-gtk2 fcitx-ui-classic fcitx-ui-light fcitx-rime

im-switch -s fcitx

fcitx

```
need to reboot


### How to kill a process on port 80 on ubuntu
 
```
sudo kill `sudo lsof -t -i:9001`
```

http://stackoverflow.com/questions/9346211/how-to-kill-a-process-on-a-port-on-ubuntu


### change ubuntu timezone

```
sudo dpkg-reconfigure tzdata
```
