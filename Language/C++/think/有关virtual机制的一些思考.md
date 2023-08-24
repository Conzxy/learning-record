# Virtual function VS Function Pointer
> [https://stackoverflow.com/questions/17959246/virtual-function-vs-function-pointer-performance](https://stackoverflow.com/questions/17959246/virtual-function-vs-function-pointer-performance)

本质上该问题与 **“Virtual function与回调函数的区别”** 等价。
先来考虑下performance的影响：

- 调用不频繁，影响几乎可以不计（在现代编译器来看）
- 调用频繁，比如循环中，查表的指令编译器可能放在循环外围，因此影响不大，其他情况暂时不清楚，但没有想象那么大。

所以不要为了XXX性能而不利用虚函数+继承来抽象一些接口。
# Virtual function VS Callback
虚函数本质上就是回调，但不是纯粹的回调，而是被类型束缚了范围，将其行为和类型及其类型的数据绑定在了一起。
如果你没有必要派生一个新类型并强制绑定在一起，是没有必要用虚函数，采用更灵活的回调（`std::function<>`）更合适。
回调强调的是行为，数据被绑定到回调本身而不是特定类型。

从概念和适用范围来说，回调可以视作回调的超集，因此在C++中类似C用回调实现虚函数是可行的。
至于是否可取，我的看法是这样的：

- 如果是库抽象出去让用户使用的话，回调更适合，灵活度高
- 如果是库默认继承的，比如一个继承体系不需要用户做任何事，用回调实现虚函数就相当于”脱裤子放p“，这种场景正如上所说更适合继承。

`kanon`采用回调很大程度也是这个原因。
