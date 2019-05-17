#!/bin/bash

FC=gfortran
CC=gcc
FFLAGS=-O2 -g
CFLAGS=${FFLAGS}
SRC=cublas.f90 cublas_core.f90 cublas_v2.f90 cufft.f90 openacc_cublas.f90 cublasxt.f90
OSRC=$(patsubst %.f90, %.o, $(SRC))

all: build

%.o : %.f90
	$(FC) $(FFLAGS) -c $< -o $@

build: $(OSRC)

clean:
	rm -f *.mod *.o *~
