- [ ] vset no weight version
* [x] linenoise -> linenoise-ng
linenoise-ng的API不完整，换成replxx改写成功。
replxx可以跨win/mac/linux
* [ ] Configuration继承MmbpMessage
* [ ] Client shortcut key（or single handler？）
* [x] 增加选项表示log
* [ ] CLI支持'str'表示整体
* [ ] ReservedArray 是否进行默认初始化
* [x] 版本号（binary）
* [ ] server shrink buffer
* [ ] server pipeline
* [ ] multithread -> config
* [x] `GetCliCommand()` 等加断言
* [ ] 多线程采用trylock()来判断是否被锁住，保证同一时间，每个线程都占用一个DB instance