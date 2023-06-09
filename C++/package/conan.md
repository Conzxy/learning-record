# 为什么需要语言层面的包管理器
C++一直缺少一个官方的管理开发包（包括软件包和库包等），我想这主要是因为C++的编程环境的多样性，特别是考虑到跨平台问题，就得应付各种OS、Archtecture、Compiler。而对此，标准委员会是不管这事的，它只管制定标准，也不打算以此来吸引其他开发者到C++社区来。反观这方面，Rust的cargo、golang的go mod等之类的做得较好，并以此为卖点吸引新的开发者。话说远了。
首先，不同的平台往往环境会差异很大，比如Windows，很难不使用MSVC来进行C++开发，而MSVC很多人使用的MSBuild那套工具链，即VS的项目管理文件。而对于Linux/Unix/FreeBSD等平台，也有大量的历史遗留是使用的Makefile和autotools那套工具链，这样就造成了不统一。
尽管有CMake、XMake之类的meta-build system来处理跨平台问题，但是它们本身也需要一定的学习成本和使用成本，更关键的是缺少一个可以管理各种包的手段（XMake这里只讨论build功能）。
因此对于包管理器的需要是迫切的，这也是C++的一个短板。
首先，来谈谈基于源码的包管理。这种管理方式往往是将源码直接扔到子目录中，然后编译的时候包含它，比如我一直以来是通过git submodule的方式来进行管理的（多是我自己的轮子），但是随着依赖的层次越来越多，会发现多个submodule可能会包含相同的submodule，即出现依赖套娃现象，这不免会导致重复编译，甚至对于一个编译系统（比如CMake）来说会造成错误，即依赖重复，这要求你选择一个版本，尽管你的这些依赖版本完全一致。
可以看出，该方式存在以下问题：
* 重复编译
* 依赖重复，无法完美地处理版本选择
第一个问题要求我们将依赖存放在一个规定好的地方，都从这个地方拿依赖用就行了。这里不得不提一下各大Linux发行版的包管理器了，比如ArchLinux及其衍生版本的pacman。这类包管理器是基于二进制的，并且通常只存放一个版本，因此第二个问题无法完美解决。另一个问题就是不同发行版的包管理器拥有的包不一定一致，这个现象对于衍生版和原主可能也有区别，比如Manjaro和Arch，差异不仅体现在包名，更体现在包的内容和版本。因此对于编程和运行环境来说可能不是最佳的，会出现各种莫名的兼容问题。
基于二进制的包管理器还一个问题就是不好直接针对源码进行修改，然后进行patch以及PR等之类的操作，这点基于源码的管理方式可以处理的很好。
所以我们迫切需要一个统一的支持版本选择、不受系统约束的包管理器，该包管理器既能管理源码，提供编辑源码的功能，又能管理二进制，从而避免重复的编译。
这方面，我比较中意的是[conan](https://github.com/conan-io/conan)，相比[vcpkg](https://github.com/microsoft/vcpkg)，conan采用python和txt作为配置文件，前者提供了灵活度，通常被包作者使用，后者引入依赖易用，通常被包用户使用。除此之外，conan支持去中心化，即允许自己搭建自己的服务器存放包，并加以管理。
conan也提供了一个[远程包管理中心](https://conan.io/center/)，里面存放的多是较为流行的包，比如protobuf、zlib等。在github有个仓库管理该中心的所有配置，也欢迎conan用户提供包。
> 本文讨论的是conan 2.0

自用的canon recipe我都放到了[github](https://github.com/Conzxy/conan-recipe)上，包括安装包、消费包和编写包。
因此这里不赘述。

# FAQ
* 能否缓存二进制中间文件
缓存二进制中间文件，可以避免全量编译

* 是否采用自己生成的XXXConfig.cmake
conan这套机制不好搞，还是老老实实写package_info()为好，结合install和components.requires可以实现依赖传递。

* 如果将自己生成的config提供给consumer使用
禁用conan的config生成，并将config在package folder中的路径加入到`CMAKE_MODULE_PATH`中。
> `CMAKE_MODULE_PATH` 说简单点就是`find_package()`和`include()`的搜索路径，具体说明见[文档](https://cmake.org/cmake/help/latest/variable/CMAKE_MODULE_PATH.html)。
```python
class KanonRecipe(ConanFile):
[..]
	def package_info(self):
		# append the path to the `CMAKE_MODULE_PATH` variable in `CMake`
		self.cpp_info.builddirs.append('lib/cmake/kanon')
		# option:
		# module
		# config  <- generate xxx-config.cmake(and other *.cmake) files
		# both <- same as config
		# none <- will disable module mode also, but also works
		self.cpp_info.set_property('cmake_find_mode', 'module')
		# or
		# self.cpp_info.set_property('cmake_find_mode', 'none')
[..]
```
禁用conan生成config文件的方法是通过浏览conan的代码发现的（根据可能的关键词搜索）：
```python
# /conan/tools/cmake/cmakedeps/cmakedeps.py
    @property
    def content(self):
            [..]
            cmake_find_mode = self.get_property("cmake_find_mode", dep)
            cmake_find_mode = cmake_find_mode or FIND_MODE_CONFIG
            cmake_find_mode = cmake_find_mode.lower()
            # Skip from the requirement
            if cmake_find_mode == FIND_MODE_NONE:
                # Skip the generation of config files for this node, it will be located externally
                continue

            if cmake_find_mode in (FIND_MODE_CONFIG, FIND_MODE_BOTH):  # <- Disable config file generation
                self._generate_files(require, dep, ret, find_module_mode=False)

            if cmake_find_mode in (FIND_MODE_MODULE, FIND_MODE_BOTH): # <- Allow the search of module path
                self._generate_files(require, dep, ret, find_module_mode=True)
            [..]
```
其余细节参考我给conan repo发的[issue](https://github.com/conan-io/conan/issues/14048)

除了在打包时配置不生成这些文件，还可以在消费包时选择不生成，如下：
```python
def generate(self)
	deps = CMakeDeps(self)
	# Disable the kanon-config.cmake(and etc.) generation
	deps.set_property("kanon", "cmake_find_mode", "none")
	deps.generate()
```