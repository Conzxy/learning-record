
由于Windows并没有一个从属于OS平台的包管理器，因此对于cpper管理第三方库往往会比较棘手。
自然，自己手动拉取源码，编译导出DLL/LIB太折磨人了，所以还是试图找了一下有什么windows下的包管理器比较流行。
## vcpkg
看了一下微软的vcpkg，就先试下。
具体可以参考[github的README](https://github.com/microsoft/vcpkg/blob/master/README_zh_CN.md#%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B-windows)的Windows部分（尽管也支持其他平台，但是我想也没太大必要）。
我主要关注的是它如何与CMake工程接轨，让我轻松。
### 命令
```cpp
.\vcpkg install [package]
.\vcpkg search [search term]
```
### VS CMake工程
> 打开 CMake 设置选项，将 vcpkg toolchain 文件路径在 CMake toolchain file 中：[vcpkg root]/scripts/buildsystems/vcpkg.cmake

### VsCode CMake工程
依赖扩展：`CMake Tools`，修改workspace的`settings.json`（不推荐修改user的该文件）。
具体细节参考[文档](https://github.com/microsoft/vscode-cmake-tools/blob/HEAD/docs/cmake-settings.md)。
这部分需要修改的就是CMake变量（或者Cache Variable）。
```json
{
  "cmake.configureSettings": {
    "CMAKE_TOOLCHAIN_FILE": "C:/src/vcpkg/scripts/buildsystems/vcpkg.cmake",
    "VCPKG_TARGET_TRIPLET": "x64-windows",
    "BUILD_STATIC_LIBS": "False",
  },
  "cmake.buildArgs": [""],
}
```
### 其他地方 CMake
```cpp
cmake -B [build directory] -S . 
    "-DCMAKE_TOOLCHAIN_FILE=[vcpkg path]/scripts/buildsystems/vcpkg.cmake"
cmake --build [build directory]
```

## 第三方库
### benchmark
```cpp
.\vcpkg install benchmark:x64-windows
```
```cmake
find_package(benchmark CONFIG REQUIRED)
target_link_libraries(main PRIVATE 
	benchmark::benchmark benchmark::benchmark_main)
```
不过莫名其妙，x64-windows安装的并不是动态库（包括导入库）而是静态库。
这样导致链接出现了问题。
解决方式：

- 手动下载benchmark源码（版本自己看），CMake指定`BUILD_SHARED_LIBS=ON`编译动态库，然后将`*.dll`复制到`vcpkg/installed/x64-windows/bin`，`*.lib`复制到`vcpkg/installed/x64-windows/lib`
### GTest
```cmake
find_package(GTest CONFIG REQUIRED)
target_link_libraries(main PRIVATE GTest::gmock 
	GTest::gtest GTest::gmock_main GTest::gtest_main)
```
