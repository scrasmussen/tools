# Debugging and Profiling

What's the difference?

**Debugging**: identify and remove errors from software

**Profiling**: program analysis. Measuring things such as 
  * time complexity
  * memory use
  * frequency and duration of function calls

_____________________

### Debugging

We will use `gdb`, the GNU Project debugger.
For a consise list of commands checkout a [cheatsheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
[GDB example](https://www.thegeekstuff.com/2010/03/debug-c-program-using-gdb)
```
$ gcc -g example.c -o runMe.exe
$ gdb ./runMe.exe
(gdb) break 10
Breakpoint 1 at 0x400232: file example.c, line 10.
(gdb) run
Starting program /root/src/debug/runMe.exe
Enter the number: 4

Breakpoint 1, main () at example.c:11
11     for (i=1; i<num; i++)
(gdb) print i
$1 = -72944
(gdb) print j
$2 = 3275
(gdb) p num
$3 = 4
```

What is the problem?
_____________________

### Profiling

* To find available profiling software type `module keyword profiling` or `ml keyword profiling`.

* Select module from list: `module load tau` or `ml tau`

* 




