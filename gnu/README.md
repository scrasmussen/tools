# Coarrays and GCC Installation

## Prereqs

Check out [prerequisites](https://github.com/sourceryinstitute/OpenCoarrays/blob/master/INSTALL.md#developer-build-and-install).

### Modules
You'll also want to know how to setup your own module files so you can load the
packages as needed. I like to keep all my module files in the directory
`~/local/lmod` and install packages under the `~/local/software/version-requiredpackage-version`.
Use whatever type of install workflow you'd like!!!

1. Add `module use $HOME/path-to/lmod` to `.bashrc`.

2. In `$HOME/path-to/lmod` you can create `.lua` files. Look  at
   [lmod documentation](https://lmod.readthedocs.io/en/latest/015_writing_modules.html)
   for more detail then needed.


Here's an example, my `opencoarrays-1.9.3-gcc-trunk.lua` file
```
local home  = os.getenv("HOME")
local path  = pathJoin(home,"local","opencoarrays/1.9.3-gcc-trunk-mpich-3.2.1")
local bin   = pathJoin(path,"bin")
local lib = pathJoin(path,"lib")

whatis("Version: 1.9.3")
whatis("Keywords: System, OpenCoarrays, Coarray Fortran, OCAF")
load("mpich-gcc-trunk")
prepend_path("PATH",bin)
prepend_path("LD_LIBRARY_PATH",lib)
```
Note: I've also created module files for my MPICH and GCC installations that
      I've setup in the `mpich-gcc-trunk.lua` file.

3. To load the module type `module load opencoarrays-1.9.3-gcc-trunk` or the
   shorter `ml opencoarrays-1.9.3-gcc-trunk`.

## GCC Installation Instructions

1. Clone [repo](https://github.com/gcc-mirror/gcc) or download [release](https://github.com/gcc-mirror/gcc/releases)

2. `cd` to source directory.

3. Run `contrib/download_prerequisites` to make life a lot easier. Note, if you
   build `gcc` with a different compiler you will need to manually remove the
   packages this installs.

4. `mkdir build` or whatever you like to call your build directories.

5. `cd build`

6. `../configure --prefix=${HOME}/path/to/installation --enable-languages=c,c++,fortran --disable-multilib --disable-bootstrap`
   *NOTE*: Whenever I install something I like to stick the configuration in a
   	   bash script, I always call mine `x.sh`. It makes live easier to
	   reconfigure by typing `x.sh` instead retyping or finding what you
	   previously typed. Also it is an easily found record of your config
	   options.

7. `make -j 8`

8. `make install`


## MPI Installation

1. Download [MPICH](https://www.mpich.org/downloads/)

2. It is useful load a version of MPI already on your system and enter
   `mpicc -v`. It will show flags that MPI was configured with. It is good to
   know these flags since the configuration might be fine-tuned to make the MPI
   quicker.

3. Create bash script with the following or similar flags.

```
#!/bin/bash

../configure \
    --prefix=$HOME/path/to/install/mpich/3.3-gcc-8.2.0 \
    --with-thread-package=pthreads \
    --enable-fast --enable-shared \
    --enable-sharedlibs=gcc --enable-static \
    --enable-f77 --enable-fc --enable-cxx
```

4. `mkdir build; cd build`

5. Run configuration script

6. `make -j 8` and `make install`


## Coarrays Installation

1. Clone [OpenCoarrays](https://github.com/sourceryinstitute/OpenCoarrays)

2. Create bash script with the following or similar flags
```
#!/bin/bash

cmake ../  \
      -DCMAKE_INSTALL_PREFIX=${HOME}/path/to/install/opencoarray/trunk-gcc-9.x-mpich-3.3   \
      -DCMAKE_C_FLAGS="-g -O3" \
      -DCMAKE_C_COMPILER=gcc \
      -DMPI_C_COMPILER=${HOME}/path/to/mpich/3.3-gcc-9.x/bin/mpicc
```

3. `mkdir build; cd build`

4. Run configuration script

5. `make -j 8` and `make install`

## Have Fun!

Now that you've installed OpenCoarrays, check out the
(getting started)[https://github.com/sourceryinstitute/OpenCoarrays/blob/master/GETTING_STARTED.md]
page!