> A _hook_ is a mechanism by which an application can intercept events, such as messages, mouse actions, and keystrokes. A function that intercepts a particular type of event is known as a _hook procedure_. A hook procedure can act on each event it receives, and then modify or discard the event.

简而言之, hook就是消息拦截器, 可以拦截推送到消息队列中的消息.

> The system maintains a separate hook chain for each type of hook.]
> A _hook chain_ is a list of pointers to special, application-defined callback functions called _hook procedures_.
> The hook procedures for some types of hooks can only monitor messages; others can modify messages or stop their progress through the chain, preventing them from reaching the next hook procedure or the destination window.

# Hook Callback
```cpp
/**
 * @param nCode: The _nCode_ parameter is a hook code that the hook procedure uses to determine the action to perform. The value of the hook code depends on the type of the hook; each type has its own characteristic set of hook codes.
 * @param wParam lParam: The values of the _wParam_ and _lParam_ parameters depend on the hook code, but they typically contain information about a message that was sent or posted.
 */
LRESULT CALLBACK HookProc( int nCode, WPARAM wParam, LPARAM lParam ) { 
	// process event ... 
	return CallNextHookEx(NULL, nCode, wParam, lParam); 
}
```
## Install
```cpp
HHOOK SetWindowsHookExA(
  [in] int       idHook,
  [in] HOOKPROC  lpfn,
  [in] HINSTANCE hmod,
  [in] DWORD     dwThreadId
);
```
The [**SetWindowsHookEx**](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setwindowshookexa) function always installs a hook procedure at the beginning of a hook chain. When an event occurs that is monitored by a particular type of hook, the system calls the procedure at the beginning of the hook chain associated with the hook. Each hook procedure in the chain determines whether to pass the event to the next procedure. A hook procedure passes an event to the next procedure by calling the [**CallNextHookEx**](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-callnexthookex) function.

# Hook Type
## WH_GETMESSAGE
The **WH_GETMESSAGE** hook enables an application to monitor messages about to be returned by the [**GetMessage**](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getmessage) or [**PeekMessage**](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-peekmessagea) function. You can use the **WH_GETMESSAGE** hook to monitor mouse and keyboard input and other messages posted to the message queue.
```cpp
/**
 * @param nCode:
 * HC_ACTION: must process the message
 * <0: must pass to `CallNextHookEx`
 * @param wParam: whether the message has been removed
 * - PM_NOREMOVE
 * - PM_REMOVE
 * @param lParam: MSG* 
 */
LRESULT CALLBACK GetMsgProc(
  _In_ int    code,
  _In_ WPARAM wParam,
  _In_ LPARAM lParam
);
```
## WH_MOUSE
The **WH_MOUSE** hook enables you to monitor mouse messages about to be returned by the [**GetMessage**](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getmessage) or [**PeekMessage**](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-peekmessagea) function. You can use the **WH_MOUSE** hook to monitor mouse input posted to a message queue.
```cpp
/**
 * @param nCode
 * <0: Call `CallNextHookEx` and return its value
 * HC_ACTION(0): mouse message
 * HC_NOREMOVE(3): mouse message that has not been removed from message queue
 * @wParam: identifier
 * @lParam: MOUSEHOOKSTRUCT*
 */ 
LRESULT CALLBACK MouseProc(
  _In_ int    nCode,
  _In_ WPARAM wParam,
  _In_ LPARAM lParam
);

typedef struct tagMOUSEHOOKSTRUCT {
  /* screen pos */
  POINT     pt;
  /* window handle */
  HWND      hwnd;
  UINT      wHitTestCode;
  ULONG_PTR dwExtraInfo;
} MOUSEHOOKSTRUCT, *LPMOUSEHOOKSTRUCT, *PMOUSEHOOKSTRUCT;
```
## WH_MOUSE_LL
The **WH_MOUSE_LL** hook enables you to monitor mouse input events about to be posted in a thread input queue.
```cpp
/**
 * @param nCode
 * <0: Call `CallNextHookEx`
 * HC_ACTION(0)
 * @param wParam: WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE, WM_MOUSEWHEEL, WM_RBUTTONDOWN or WM_RBUTTONUP.
 * @param lParam: MSLLHOOKSTRUCT*
 */
LRESULT CALLBACK LowLevelMouseProc(
  _In_ int    nCode,
  _In_ WPARAM wParam,
  _In_ LPARAM lParam
);

/**
 * @param pt
 * @param mouseData:
 */
typedef struct tagMSLLHOOKSTRUCT {
  POINT     pt;
  DWORD     mouseData;
  DWORD     flags;
  DWORD     time;
  ULONG_PTR dwExtraInfo;
} MSLLHOOKSTRUCT, *LPMSLLHOOKSTRUCT, *PMSLLHOOKSTRUCT;
```