## struct和class不被视为同一个符号
```cpp
// A.h
class B;

void f(B const &);

// B.h
struct B {
  // ...
};

// A.cc
void f(B const &) {
}
```
像上面这种情形，会触发`LNK:2001 无法解析的外部符号void f(B const &)...`。
Fix: 将`class B`改为`struct B`即可。

## __declspec(dllexport/dllimport)
[__declspec的MS DOC](https://learn.microsoft.com/en-us/cpp/cpp/declspec?view=msvc-170)
[__declspec(dllexport/dllimport)的MS DOC](https://learn.microsoft.com/en-us/cpp/cpp/dllexport-dllimport?view=msvc-170)

> [https://stackoverflow.com/questions/8863193/what-does-declspecdllimport-really-mean](https://stackoverflow.com/questions/8863193/what-does-declspecdllimport-really-mean)
> __declspec(dllimport) is a storage-class specifier that tells the compiler that a function or object or data type is defined in an external DLL.
> The function or object or data type is exported from a DLL with a corresponding __declspec(dllexport).

> [https://stackoverflow.com/questions/8863193/what-does-declspecdllimport-really-mean](https://stackoverflow.com/questions/8863193/what-does-declspecdllimport-really-mean)
> __declspec(dllexport) tells the compiler to inform the linker that these symbols need to be placed in the export table (when compiling the .dll), and to put those symbols in the import library .lib. When compiling the program that links with the .dll, __declspec(dllimport) tells the compiler to produce a rip-relative memory-indirect call (which the linker will fill resolve to point to the import table) rather than the usual relative direct instruction to the undefined function (which, as it can't modify the instruction, the linker inserts the relative address of a thunk and then creates the thunk, inside which it places the rip-relative memory-indirect jump to the function pointer in the import table). This is a code size and speed optimisation. It is the import library .lib that tells the linker which symbols are exported by the .dll and is used as a guide to create the import table based on the intersection of those with the matching extern symbol table entries and create any necessary thunks in the .text segment.
> 
> [https://learn.microsoft.com/en-us/cpp/build/importing-function-calls-using-declspec-dllimport?view=vs-2019](https://learn.microsoft.com/en-us/cpp/build/importing-function-calls-using-declspec-dllimport?view=vs-2019) [https://learn.microsoft.com/en-us/cpp/build/importing-data-using-declspec-dllimport?view=vs-2019](https://learn.microsoft.com/en-us/cpp/build/importing-data-using-declspec-dllimport?view=vs-2019) [https://stackoverflow.com/a/4490536/7194773](https://stackoverflow.com/a/4490536/7194773)


```cpp
#if defined(_MSC_VER)
# define EXPORT_ATTR __declspec(dllexport)
# define IMPORT_ATTR __declspec(dllimport)
# define NO_EXPORT_ATTR
# define DEPRECATED_ATTR __declspec(deprecated)
#else defined(__clang__) || defined(__GNUC__) || defined(__GNUG__)
# define EXPORT_ATTR __attribute__((visibility("default")))
# define IMPORT_ATTR __attribute__((visibility("default")))
# define NO_EXPORT_ATTR __attribute__((visibility("hidden")))
# define DEPRECATE_ATTR __attribute__((__deprecated__))
#endif //!defined(_MSC_VER)

// 无论是编译还是使用静态库都是该宏
#ifdef XXX_STATIC_DEFINE
# define XXX_API 
# define XXX_NOT_API 
#else // XXX_STATIC_DEFINE
// 由于在其他平台或编译器不称作DLL
// 这里取名为XXX_EXPORTS
# ifndef XXX_API
#  ifdef XXX_EXPORTS
/* building shared library */
#   define XXX_API EXPORT_ATTR
#  else // XXX_EXPORTS
/* using this library */
#   define XXX_API IMPORT_ATTR
#  endif // !XXX_EXPORTS
# endif // !XXX_API
# ifndef XXX_NOT_API
#  define XXX_NOT_API NO_EXPORT_ATTR
# endif // !XXX_NO_EXPORT 
#endif // !XXX_STATIC_DEFINE

#ifndef XXX_DEPRECATED
# define XXX_DEPRECATED DEPRECATE_ATTR
#endif // !XXX_DEPRECATED

#ifndef XXX_DEPRECATED_API
# define XXX_DEPRECTED_API XXX_API XXX_DEPRECATED
#endif // !XXX_PRECATED_API

#ifndef XXX_DEPRECATED_NOT_API
# define XXX_DEPRECATED_NOT_API XXX_NO_EXPORT XXX_DEPRECATED
#endif // !XXX_DEPRECATED_NOT_API
```
## 强制内联
```cpp
#if defined(__GNUC__) || defined(__clang__)
# define XXX_ALWAYS_INLINE __attribute__((always_inline))
#elif defined(_MSC_VER) /* && !defined(__clang__) */
# define XXX_ALWAYS_INLINE __forceinline
#else
# define XXX_ALWAYS_INLINE
#endif // !defined(__GUNC__) || defined(__clang__)
```
## 检查lib是否为静态库
在Windows（MSVC），.lib代表两种文件（尽管共用一个后缀艹）：

- 静态库
- DLL的导入库（import library）

这样难免不会带来困惑，VS提供了一个工具可以判断。
打开`Developer Command Prompt for VS 20XX`/`Developer Powershell for VS 20XX`，里面有些内置的可执行程序（我不知道路径）。
命令格式：`lib /list *.lib`

## 禁用warning
设置编译器选项中的_warning level_：`/W0`。
> [https://stackoverflow.com/questions/63627279/visual-studio-disable-warnings-for-files-in-specific-directories](https://stackoverflow.com/questions/63627279/visual-studio-disable-warnings-for-files-in-specific-directories)
> ![image.png](https://cdn.nlark.com/yuque/0/2023/png/34841510/1675581238532-5eefb134-ca83-420e-95cb-15bc602388c3.png#averageHue=%23fcfaf7&clientId=ucc150c6e-7b9b-4&from=paste&height=187&id=PLu8E&name=image.png&originHeight=281&originWidth=989&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61192&status=done&style=none&taskId=u9db26104-0644-4e27-9e67-1b53733087f&title=&width=659.3333333333334)

如果是在VS中并且是用的vcproj描述项目，可以在`Project Properties->C/C++->General->Warning Level->select level`中设置
