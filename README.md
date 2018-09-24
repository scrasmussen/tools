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

```
$ gcc -g example.c -o runMe.exe
$ gdb ./runMe.exe
```

### Profiling

* To find available profiling software type `module keyword profiling` or `ml keyword profiling`.

* Select module from list: `module load tau` or `ml tau`

* 




