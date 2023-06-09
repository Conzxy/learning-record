# 唤起（Invoking）GDB
* gdb PROGRAM（硬盘上的可执行文件）
* gdb PROGRAM CORE（指定Coredump文件还原crash的现场）
* gdb -p [pid]（运行中程序的pid）

如果指定可执行文件的实参列表：
* gdb --args PROGRAM argv...

一般启动gdb，会出现一些信息，包括版权，许可证等，通常用不到，避免其占据终端空间：
* gdb --silent ...
