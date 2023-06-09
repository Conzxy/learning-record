这个问题一开始我也没想清楚，但其实切入点在于 **key的语义** 。
key本身也是对象，自然也具备语义：**引用语义** 和 **值语义** 。

如果key是引用的其他对象，那么生命周期得考虑清楚，不然引用会失效。
如果key是值语义，那么生命周期由key自己掌控，不用担心失效问题。

```cpp
std::vector<std::string> strs;
std::map<char const*, xxx> map; // char const* is OK.
```
