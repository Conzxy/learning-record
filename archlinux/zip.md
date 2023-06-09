# zip用法
> FYI man zip/unzip

## 打包
最基本的用法：
```shell
zip [archive name] files...
```
注意，如果zip文件已存在，需要更新文件不能只是覆盖，因为多余的文件不能被删除。

## 解包
```shell
unzip [archive name] -d [directory]
```
如果不指定目录，那么默认解压到当前目录。

## 解压乱码问题
由于unzip并不能指定编码，因此这里可以采用其他压缩软件解决。
```bash
# pacman -S unarchiver
$ unar --help
```
除此之外，还可以用其他方式，参考[该帖](https://tieba.baidu.com/p/4095309703?red_tag=1067663638)，不过我没尝试。
