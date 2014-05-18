MacBook Pro with Retina display 的标配内存是8GB，这个内存足够日常使用了，考虑到 SSD 硬盘寿命的问题，建议关闭系统的虚拟内存（Swap），避免频繁写入。关闭系统 swap 还可以提高性能（参考 Linux 性能监测：Memory 和 Linux 性能监测：IO 的 swap 部分）。

查看当前正在使用的虚拟内存：
```
$ sysctl vm.swapusage
vm.swapusage: total = 1024.00M  used = 354.50M  free = 669.50M  (encrypted)
```
关闭虚拟内存以后，系统里还保留着这些用作虚拟内存的交换文件，可以删除：
```
$ sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist

$ sudo rm /private/var/vm/swapfile*

```
用了一段时间还没有遇到系统不稳定问题，如果发现系统不稳的话可以重新开启虚拟内存：

```
$ sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist
```
