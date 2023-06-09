## Clangd
## clangd参数
```json
--background-index
--compile-commands-dir=build
-j=4
--query-driver=/usr/bin/clang++
--all-scopes-completion
--completion-style=detailed
--pch-storage=disk
--header-insertion=never
```
## Inlay hints
有点比较烦的是函数调用中的实参会提示其类型，还有auto也会，这些其实在编写代码的时候都是不需要的。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1675602819154-e978f59f-91f7-4a1c-9e13-3a22d75812aa.png#averageHue=%23232221&clientId=u84f58c2a-765f-4&from=paste&height=76&id=u3c6049be&name=image.png&originHeight=114&originWidth=1066&originalType=binary&ratio=1&rotation=0&showTitle=false&size=24574&status=done&style=none&taskId=ue4bac124-8f2a-4ed9-83ec-89fe784c5c1&title=&width=710.6666666666666)
打开_命令板(Command palette)\_选择`Clangd: Toggle inlay hints`即可。
另外一种做法就是创建`.clangd`文件，配置如下字段：
```json
InlayHints:
  Enabled: Yes
  ParameterNames: Yes
  DeducedTypes: No
```
