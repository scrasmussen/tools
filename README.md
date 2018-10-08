# Debugging, Profiling, and Documentation

What's the difference?

**Debugging**: identify and remove errors from software

**Profiling**: program analysis. Measuring things such as
  * time complexity
  * memory use
  * frequency and duration of function calls

_____________________

### Debugging

We will use `gdb`, the GNU Project debugger.
For a concise list of commands checkout a [cheatsheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
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

## Profiling

* To find available profiling software type `module keyword profiling` or `ml keyword profiling`.

* Select module from list: `module load tau` or `ml tau`.
Type `ml` or `module list` to check that the modules have loaded correctly.

* Find the configuration of the TAU Makefile, `ls` the directory to find other configuration options.

```
$ echo $TAU_MAKEFILE
/apps/software/TAU/2.27-foss-2018a/x86_64/lib/Makefile.tau-papi-mpi-pdt
```
* Compile code, add `--help` to see the compiler options.

```
$ tau_cc.sh tau_example.c -o runMe.exe
$ mpirun -np $NUMPROCESSES ./runMe.exe
```

* A `profile.X.Y.Z` file will be created.
To see the results use `pprof` or `paraprof`.
`pprof` shows the results on the command line and `paraprof` shows the results in a GUI.
Use `pprof` to check the number of times a function is called and how much time is spent in it.
```
$ pprof profile.X.Y.Z
```

_____________________

## Documentation

**Q:** Why should I document?

**A:** "No matter what you are developing, chances are that some day you
or one of your colleagues will have to revisit it. When that day comes,
you will not remember so vividly what you wrote and why." - tomerpacific

Here's a good [short example of code](http://www-numi.fnal.gov/offline_software/srt_public_context/WebDocs/doxygen-howto.html) documented using Doxygen.

Here's what output using Doxygen might look like:
![alt text](https://mcuoneclipse.files.wordpress.com/2012/06/dependency-graph.png)
