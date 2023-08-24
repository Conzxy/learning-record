- `project(... LANGUAGE CXX)`请不要将语言限定死，因为这使得C源文件在`add_library()/add_executable()`等CMD不会被编译，从而出现莫名奇妙的链接错误（因为C源文件的symbol没有导入）。
## CMake Builtin Variable
> https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html

|  变量名  |  信息  |
| --- | --- |
| CMAKE_CURRENT_FUNCTION_LIST_DIR（3.17） | function所在文件的路径（避免在function外部定义变量表示CMAKE_CURRENT_LIST_DIR） |
| CMAKE_CURRENT_LIST_DIR | 当前正在被处理文件的路径（包括CMakeLists.txt和include()包含的文件等）<br>如果是在function中，那么是调用该function的文件路径而不是定义该function的文件。 |
| CMAKE_CURRENT_SOURCE_DIR | 当前CMakeLists.txt所在目录 |
| CMAKE_CURRENT_BINARY_DIR | 当前CMakeLists.txt对应的build目录 |
| CMAKE_BINARY_DIR | 顶层CMakeLists.txt对应的build目录 |
| CMAKE_SOURCE_DIR | 顶层CMakeLists.txt对应的目录（根目录） |
| PROJECT_SOURCE_DIR | 最近project()的CMakeLists.txt所在目录 |
| PROJECT_BINARY_DIR | 最近project()的CMakeLists.txt对应的build目录 |
| PROJECT_NAME |  |
| PROJECT_VERSION |  |
| PROJECT_VERSION_MAJOR |  |
| PROJECT_VERSION_MINOR |  |
| PROJECT_VERSION_PATCH |  |
| PROJECT_VERSION_TWEAK |  |

## 识别编译器
[CMAKE_CXX_COMPILER_ID](https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html#variable:CMAKE_%3CLANG%3E_COMPILER_ID)
比较常用的：

- `Clang`
- `GNU`
- `MSVC`

## else if()/elif()都不正确
CMake非主流：`elseif()`

## Install相关
Install需要考虑如下文件：

- config_version(${PREFIX}ConfigVersion.cmake）
- project_config(${PREFIX}Config.cmake)
- config_targets(${PREFIX}ConfigTargets.cmake)

其中project_config通过`${PREFIX}Config.cmake.in`作为输入覆盖一些内容获得（如果有需要的话）。
如果没有必要捕获一些变量，是可以将config_targets作为Config.cmake的内容的（`configure_file()`拷贝下）。

需要用到的install指令有：

- install(TARGETS)

指定TARGETS的一些规则，比如RUNTIME、ARCHIVE的安装目录，并将其与一个export name关联。

- install(EXPORT)

将export name关联的targets确实地写入到合适的文件里。

- install(FILES)
[fold]
```cmake
# 伪码
include(GUNInstallDirs)
set(project_config_in_file "${CMAKE_CURRENT_LIST_DIR}/cmake/${PROJECT}Config.cmake.in)
set(project_config_out_file "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}Config.cmake)
set(config_version_file "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT}ConfigVersion.cmake)
set(config_targets_filename "${PROJECT}ConfigTargets.cmake)
set(export_dest_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT})

# Specify some rules of targets
install(
	TARGETS ${targets}
	EXPORT ${export_name}
	RUNTIME "${CMAKE_INSTALL_BINDIR}"
	ARCHIVE "${CMAKE_INSTALL_LIBDIR}"
	LIBRARY "${CMAKE_INSTALL_LIBDIR}"
)

# Export the ConfigTargets.cmake to build directory
# To make user use find_package() successfully but don't install, 
# you can use export(PACKAGE <name>) command to register build dir to
# ~/.cmake/packages/
export (EXPORT ${export_name}
	NAMESPACE ${PROJECT}::
	DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/${config_targets_filename}")

# Generate and install ConfigTargets.cmake
install(EXPORT ${export_name} 
	DESTINATION "${export_dest_dir}"
	NAMESPACE ${PROJECT}::
	FILE "${config_targets_filename}")

include(CMakePackageConfigHelpers)
# Generate Config.cmake and ConfigVersion.cmake
configure_package_config_file("${project_config_in_file}" "${project_config_out_file}"
	DESTINATION "${export_dest_dir}")
write_basic_package_version_file("${config_version_file}"	COMPATIBILITY SameMajorVersion)
# Install Config.cmake and ConfigVersion.cmake
install(FILES "${config_version_file}" "${project_config_out_file}" 
	DESTINATION "${export_dest_dir}")
```
