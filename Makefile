CC=gcc
# `=` set
# `:=` immediate set, expands values during assignment
# `?=` set if absent
# `+=` appends
FC ?= gfortran
# It very good/important to turn on warnings, we also add debugging flag
CFLAGS=-g -Wall -Wextra -pedantic
FFLAGS=$(CFLAGS)
OBJS=example.o # you can add as many .o files as you want
exe=runMe.exe


%.o:%.c
	$(CC) -c $< $(CFLAGS)
%.o:%.f90
	$(FC) -c $< $(FFLAGS)

# all get called when you just type `make`
all: build

build: $(OBJS)
	$(CC) $(OBJS) -o $(exe)

run:
	./$(exe)

clean:
	rm -f *~ *.exe *.o


what: will
	echo "what"
will: this
	echo "will"
this: print
	echo "this"
print:
	echo "print"

echo: foo bar

foo:
	@echo "foo"
bar:
	@echo "bar"
