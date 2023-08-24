## 更改语言为英文等其他语言（即非中文）
打开Visual Studio Installer：

- 工具->获取工具和功能
- windows搜索"Visual Studio Installer"

点击语言包下载其他语言。
然后选项搜索“区域设置”，更改为其他语言。

## 自动换行设置
当一行过长折叠该行，在vim中这个是默认使能的，称为屏幕行和实际行。
在VS中这个功能是默认禁止的，需要手动启动：
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676365821454-cb810e94-e80d-429f-8955-21b87e3764ef.png#averageHue=%23ededec&clientId=u67a7a348-8ed5-4&from=paste&height=484&id=u49f86078&name=image.png&originHeight=484&originWidth=741&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38480&status=done&style=none&taskId=u67ed4e70-14b2-40c3-92b2-2f2bb7cc967&title=&width=741)

## 智能提示上下移动
将上下箭头键配置为`Alt+k`和`Alt+j`，分别对应`Edit.LineUp`和`Edit.LineDown`配置项。
[[https://stackoverflow.com/questions/18153541/scrolling-through-visual-studio-intellisense-list-without-mouse-or-keyboard-arro/18744507#18744507]]

## Formatter
VS除了内置的format功能外，还默认支持clang-format，但是有很多坑需要亲自试过才知道。

### 完全禁用clang-format
完全禁用需要两个地方都disable，只是单纯地disable clang-format功能是不够的，它依然可以起作用，比如覆盖VS的tabs配置项。
* 禁用Use adaptive formatting：
![[Pasted image 20230714133251.png]]
* 禁用Enable ClangFormat support
![[Pasted image 20230714133321.png]]
否则你即使tabs配置项中是keep tabs，也依然可能根据clang format的配置插入空格。