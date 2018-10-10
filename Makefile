CC=gcc
FC ?=gfortran
CFLAGS=-g -Wall -Wextra -pedantic
FFLAGS=$(CFLAGS)
OBJS=example.o

%.o:%.c
	$(CC) -c $< $(CFLAGS)
%.o:%.f90
	$(FC) -c $< $(FFLAGS)


all: build

build: $(OBJS)
	$(CC) $(OBJS) -o runMe.exe

run:
	./runMe.exe

clean:
	rm -f *~ *.exe *.o
