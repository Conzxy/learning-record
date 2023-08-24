# 终端使用
## Windows
### Powershell
```shell
$env:http_proxy="http://127.0.0.1:7890"  
$env:https_proxy="http://127.0.0.1:7890"
$env:http_proxy=""  
$env:https_proxy=""
```


目前不推荐将系统代理覆盖为clash的代理地址, 当代理不可用时, 整个机器会无法连接网络, 因为此时所有请求都是通过clash路由的, 无法切换为直连.