## 为什么不使用`rand()`, `srand()`, `RAND_MAX`？
- `rand()`作为一个PRNG(pesudo-random number generator)，其采用的算法是固定的（依赖具体实现），一般为LCG算法（Linear Congruential generator），该算法性能尚可且对存储要求不高（即不需要过多的状态），但是有些毛病，所以也被诟病。问题在于生成伪随机数的算法无法被替换，根据具体场景更换更合适的算法。
- 没有分布用于处理`rand()`生成的随机数，由于`rand()`生成的随机数在[0, RAND_MAX]之间，所以如果我们要生成[0, 1)之间的浮点数，需要`rand() / (RAND_MAX+1.)`，更别说支持更复杂的正态分布等分布了。

C++11引入了多种随机数生成器，包括伪随机数和正随机数（如果可以将系统硬件作为熵源），还引入了多种分布来处理生成的随机数。
一般的做法就是通过`std::random_device`获取正随机数作为种子给伪随机数生成器，然后将其作为实参给分布函数对象得到最终结果。
```cpp
#include <random>

std::random_device rd; // get true random number
std::mt19337 mt(rd()); // pesudo-random number generator
std::uniform_real_distribution</* double */> urd(0., 1.); // distribution
auto rn = urd(mt); // generate random number
```

## Reference
[https://en.cppreference.com/w/cpp/numeric/random](https://en.cppreference.com/w/cpp/numeric/random)
[https://stackoverflow.com/questions/19665818/generate-random-numbers-using-c11-random-library](https://stackoverflow.com/questions/19665818/generate-random-numbers-using-c11-random-library)[https://stackoverflow.com/questions/52869166/why-is-the-use-of-rand-considered-bad](https://stackoverflow.com/questions/52869166/why-is-the-use-of-rand-considered-bad)
