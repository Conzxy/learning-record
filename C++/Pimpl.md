
# Pros
> [https://stackoverflow.com/questions/8972588/is-the-pimpl-idiom-really-used-in-practice](https://stackoverflow.com/questions/8972588/is-the-pimpl-idiom-really-used-in-practice)

- 简化编译依赖，进而可能减少增量编译时间
- 动态库的ABI(Application Binary Interface)兼容性，可以任意修改实现和添加新接口，因为类内存布局不变。
- 隐藏具体实现（这个是最不能理解的，不论是对于开源还是闭源）
- [实现跨平台API（又一说 N * M问题？）](https://stackoverflow.com/questions/2413172/cross-platform-c-code-architecture)

# Cons

- 对于开发和维护增加了新的工作量，并且维护的文件也变多了
- 不直观，晦涩

至于多一次调用，相比虚函数来说是相当cheap的，因为不需要查虚表（[多了一些汇编指令且难以优化](https://softwareengineering.stackexchange.com/questions/191637/in-c-why-and-how-are-virtual-functions-slower)）。
除此之外，转发可以内联，所以这方面的性能顾虑是没必要的。

