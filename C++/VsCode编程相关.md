## Debug
如果是使用CMake的默认Debug的话，是不能指定命令行参数的，只适用于不需要命令行参数的程序。
![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1676170764172-7889ea67-de4e-4cba-b162-e6a67655fcf7.png#averageHue=%233e453d&clientId=u8ba795ea-55b0-4&from=paste&height=157&id=u20dfa341&name=image.png&originHeight=236&originWidth=437&originalType=binary&ratio=1.5&rotation=0&showTitle=false&size=50093&status=done&style=none&taskId=u57bb48ec-63d0-4b62-9737-e5c6c98f40b&title=&width=291.3333333333333)

要指定命令行参数或是更为复杂的配置，可以编写`.vscode/launch.json`，比如msvc的配置大概如下：
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(msvc) Launch",
            "type": "cppvsdbg",
            "request": "launch",
            // Resolved by CMake Tools:
            "program": "${command:cmake.launchTargetPath}",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [
                {
                    // add the directory where our target was built to the PATHs
                    // it gets resolved by CMake Tools:
                    "name": "PATH",
                    "value": "${env:PATH}:${command:cmake.getLaunchTargetDirectory}"
                },
                {
                    "name": "OTHER_VALUE",
                    "value": "Something something"
                }
            ],
            "console": "externalTerminal"
        }
    ]
}
```
更多配置还是参考[Vscode相关文档](https://github.com/microsoft/vscode-cmake-tools/blob/main/docs/debug-launch.md#debug-using-a-launchjson-file)吧


