# C/C++使用Lua扩展

# 全局变量
```C
/**
 * 将name对应的value压栈
 * \return
 *  value类型
 */
int lua_getglobal(lua_State *L, char const *name);

/**
 * 将name对应的值设为栈顶元素，并弹栈
 */
int lua_setglobal(lua_State *L, char const *name);
```

# 表
```C
/**
 * 假设index对应的是表t，key是栈顶
 * 那么将t[key]压栈（key弹栈，位置不变）
 * \return
 *  压入值的类型，即key对于的值类型
 * \note
 *  key不需要手动管理
 */
int lua_gettable(lua_State *L, int index);

/**
 * 假设index对应的是表t，value是栈顶，key是栈顶以下的元素
 * 那么t[key] = value（将value和key弹栈）
 */
void lua_settable(lua_State *L, int index);

/**
 * 获取t[key]（index对应表t）
 *
 * \note
 *  类似于
 *  lua_pushstring((L, key);
 *  lua_gettable(L, -2);
 *  但注意并不需要将key压栈
 *
 */
int lua_getfield(lua_State *L, int index, char const *key);

/**
 *
 * \note
 *  使用前压入value
 */
void lua_setfield(lua_State *L, int index, char const *key);

/**
 * \param narr 序列的期望大小
 * \param nrec 序列外元素的期望大小
 * （P.S. 表允许混合两种）
 *
 * 用于Reserve以避免多次扩容
 */
void lua_createtable(lua_State *L, int narr, int nrec);

/** 等价于lua_createtable(L, 0, 0) */
void lua_newtable(lua_State *L);
```

# 函数
```C
/**
 * 以保护模式调用函数
 * 有错误发生，将错误信息压栈并返回错误码
 *
 * \param msgh 错误处理函数的索引
 * \return
 *  LUA_OK
 *  LUA_ERRRUN: runtime error
 *  LUA_ERRMEM: memory error
 *  LUA_ERRERR: error occurs in erro handler
 *  LUA_ERRGCMM: 
 */
int lua_pcall(lua_State *L, int nargs, int nresults, int msgh);

/**
 * 等价于 lua_pcall(L, nargs, nresults, 0)
 * 0是非法索引
 */
int lua_call(lua_State *L, int nargs, int nresults);
```

调用协议：
* 压入函数
* 压入函数实参（正序压入，即栈顶对应最后一个实参）
* 调用`lua_pcall()/lua_call()`调用函数
* 获取返回值（正序返回，即栈顶对应最后一个返回值）

# 


