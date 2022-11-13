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
