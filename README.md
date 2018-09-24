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
In the following code we use the short cuts `s` for `step` and `fin` for `finish`.
```
$ gcc -g example.c -o runMe.exe
$ gdb ./runMe.exe
(gdb) break 16
Breakpoint 1 at 0x400232: file example.c, line 16.
(gdb) run
Starting program /root/src/debug/runMe.exe
Enter the number: 3

Breakpoint 1, main () at example.c:16
16   i = 1;
(gdb) s 
18   fact(i, &j, num);
(gdb) s 
fact (i=1, j=0x7ffffffee21c, num=3) at example.c:7
7    for (i=1; i<num; i++)
(gdb) s 
8    *j=*j*i;
(gdb) print i
$1 = 1
(gdb) print j
$2 = (int *) 0x7ffffffee32c
(gdb) print *j
$3 = 0
(gdb) p num
$4 = 3
(gdb) c
Continuing.
The factorial of 4 is 0
[Inferior 1 (process 5462) exited normally]
```

What is the problem?
_____________________

### Profiling

* To find available profiling software type `module keyword profiling` or `ml keyword profiling`.

* Select module from list: `module load tau` or `ml tau`

* 




