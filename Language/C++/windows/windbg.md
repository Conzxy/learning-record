> [!reference]
> https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/user-mode-dump-files
# User-mode dump
## Full dump
- The entire memory space of a process.
- The program's executable image.
- The handle table.
- Other information that helps the debugger reconstruct the memory that was in use when the dump occurred.
> [!warning]
> Despite their names, the largest minidump file contains more information than the full user-mode dump file. For example, the `.dump /mf` and `.dump /ma` commands create larger and more complete files than the `.dump /f` command.
   In user mode, `.dump /m`[_MiniOptions_] is often the best choice. The dump files you create by using this switch might vary in size from very small to very large. By specifying the correct _MiniOptions_ switch, you can control exactly what information is included.

由于创建User-mode的FullDump使用`.dump /f` 已经不再被推荐, 推荐使用`.dump /mf`(full)或`.dump /ma`(all).

## Minidump
The size and contents of a minidump file vary depending on the program being dumped and the application doing the dumping and `the options selected`.

|`.dump` option|Effect on dump file option |
|---|---|
|`/ma`|Creates a minidump with all optional additions. The `/ma` option is equivalent to `/mfFhut`. It adds full memory data, handle data, unloaded module information, basic memory information, and thread time information to the minidump.|
|`/mf`|Adds full memory data to the minidump. All accessible committed pages owned by the target application are included.|
|`/mF`|Adds all basic memory information to the minidump. This switch adds a stream to the minidump that contains all basic memory information, not only information about valid memory. The debugger uses the information to reconstruct the complete virtual memory layout of the process when the minidump is being debugged.|
|`/mh`|Adds data about the handles that are associated with the target application to the minidump.|
|`/mu`|Adds unloaded module information to the minidump. This option is available only in Windows Server 2003 and later versions of Windows.|
|`/mt`|Adds more thread information to the minidump. The thread information includes thread times, which can be displayed by using [.ttime (Display Thread Times)](https://learn.microsoft.com/en-us/windows-hardware/drivers/debuggercmds/-ttime--display-thread-times-) when you debug the minidump.|
|`/mi`|Adds secondary memory to the minidump. _Secondary memory_ is any memory that's referenced by a pointer on the stack or backing store, plus a small region surrounding this address.|
|`/mp`|Adds process environment block and thread environment block data to the minidump. This information can be useful if you need access to Windows system information regarding the application's processes and threads.|
|`/mw`|Adds all committed read-write private pages to the minidump.|
|`/md`|Adds all read-write data segments within the executable image to the minidump.|
|`/mc`|Adds code sections within images.|
|`/mr`|Deletes from the minidump portions of the stack and store memory that aren't used to re-create the stack trace. Local variables and other data type values are also deleted. This option doesn't make the minidump smaller (the unused memory sections are zeroed), but it's useful if you want to protect the privacy of other applications.|
|`/mR`|Deletes the full module paths from the minidump. Only module _names_ are included. This option is useful if you want to protect the privacy of the user's directory structure.|

# Debug Dump file
| Command | Mean |
|--|--|
| .sympath+ | append symbol file path |
| .reload | reload module |
| !analyze -v | display and analysis of problem/exception |
| k | display stack backtrace |
| bu | set breakpoint |
| bl | breakpoint list |
| ~ | Thread Status |
| ~s | Set Current Thread |
| qd | quit and detach |
