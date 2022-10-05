# Lua Stack API
Lua与C交互主要依赖于Lua提供的API，而这些API与C进行交互主要是通过`虚拟栈（virtual stack）`。

因此了解操作栈的API是十分有必要的。

# Push elements
```C
void lua_pushnil(lua_State *L);
void lua_pushboolean(lua_State *L, int bool);
void lua_pushnumber(lua_State *L, lua_Number n);
void lua_pushinteger(lua_State *L, lua_Integer n);
void lua_pushlstring(lua_State *L, char const *s, size_t len);
void lua_pushstring(lua_State *L, char const *s);

/* 先将n个相关变量（即捕获列表的变量）先压入栈中，
   然后Lua创建闭包，并将n个变量弹栈，将C函数压入栈中，
   到时候调用会自动触发 */
void lua_pushcclosure(lua_State *L, lua_CFunction *fn, int n);

/* 接受C函数，并将为function类型的Lua值压栈 */
void lua_pushcfunction(lua_State *L, lua_CFunction *fn);
/* 等价于 #definee lua_pushcfunction(L, fn, 0); */
```

# 栈大小管理
栈的初始大小是 `LUA_MINSTACK`（5.4.4是20，之前也应该是20，具体参考`/usr/include/lua.h`)。
栈一般是不会自己主动扩容的，需要用户根据需要进行扩容。
一个例外是，如果函数返回多个值，会超出当前的栈大小，那么由Lua管理栈大小，保证多个返回值能够放到栈中。

```C
/**
 * \param sz Extra slots you need
 * \return
 *  0 indicates failure
 */
int lua_checkstack(lua_State *L, int sz);

/**
 * 当出错时，抛出错误而不是返回错误码 

 * \param msg Error message(NULL is also OK)
 */

int luaL_checkstack(lua_State *L, int sz, char const *msg);
```

注意，这个函数并不会缩容。


# 查询栈
```C
/**
 * \return
 *  1 -- success
 *  otherwise, 0
 */
int lua_is*(lua_State *L, int index);

/**
 * \return
 *  LUA_TNONE -- index is invalid
 *  LUA_TINT
 *  LUA_TBOOLEAN
 *  LUA_TNUMBER
 *  LUA_USERDATA
 *  LUA_TLIGHTUSERDATA
 *  LUA_TSTRING
 *  LUA_TFUNCTION
 *  LUA_TTABLE
 *  LUA_TTHREAD
 */
int lua_type(lua_State *L, int index);

/* conversion function */
char const *lua_typename(lua_State *L, int type);


/*********************************/
/* Conversion function           */
/*********************************/

int lua_toboolean(lua_State *L, int index);

/**
 * 返回的是C风格字符串，即有尾0终止符，但是中间也会有其他0
 * （因为Lua的字符串是原生二进制编码的）。

char const *lua_tolstring(lua_State *L, int index, size_t *len);
lua_State *lua_tothread(lua_State *L, int index);
/* 当不是该类型时，无法返回一个值表示错误，只能简单返回0 */
lua_Number lua_tonumber(lua_State *L, int index);
lua_Integer lua_tointeger(lua_State *L, int index);

/* 推荐使用下面的API */
lua_Number lua_tonumberx(lua_State *L, int index, int *isnum);
lua_Integer lua_tointegerx(lua_State *L, int index, int *isnum);
```

# 操作栈
> 注意，Lua的索引是从1开始的。

```C
/**
 * 返回栈顶索引（也是栈大小）
 */
int lua_gettop(lua_State *L);

/**
 * 设置栈顶
 * 如果index比当前栈顶要大，那么多余的会被置为nil（被回收）
 */
void lua_settop(lua_State *L, int index);

/** 
 * 弹出n个栈顶元素
 * \note
 *  #define lua_pop(L, n) lua_settop(L, -1-(n))
 */
void lua_pop(lua_State *L, int n);

/**
 * 压入stack[index]的拷贝到栈顶
 */
void lua_pushvalue(lua_State *L, int index);

/**
 * 旋转说白了就是循环移入（或移出）。
 * e.g.
 * 1 2 3 4 5(top)
 * 右旋3个元素：
 * 3 4 5 1 2
 * 
 * 针对的范围是[index, top]
 *
 * \param n 为正表示向栈顶方向旋转，为负时表示相反方向，绝对值表示旋转个数
 *          不应该大于要选择的切片大小（即[index, top]）
 */
void lua_rotate(lua_State *L, int index, int n);

/**
 * 将index的元素从栈中移除
 * \note
 *  #define lua_remove(L, index) (lua_rotate(L, (index), -1), lua_pop(L, 1))
 *  rotate将index的元素送到栈顶，然后移除
 */
void lua_remove(lua_State *L, int index);

/**
 * 将栈顶元素送到当前位置，以此来挪出空间
 * 相当于将[index, top]的元素向栈顶方向旋转了1个位置
 */
void lua_insert(lua_State *L, int index);

/**
 * 将栈顶元素送到index处（被替换），并弹栈
 */
void lua_replace(lua_State *L, int index);

/**
 * 拷贝fromindex的元素到toindex处，其他无变化
 */
void lua_copy(lua_State *L, int fromindex, int toindex);
```
