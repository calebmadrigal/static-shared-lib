all: do_test

testlib2.o: testlib2.c testlib2.h
	gcc -c -fPIC testlib2.c -o testlib2.o

libtestlib.so: testlib2.o testlib.c testlib.h
	gcc -fPIC testlib.c testlib2.o -static -shared -o libtestlib.so -lc

do_test: libtestlib.so
	gcc -fPIC do_test.c -L. -ltestlib -o do_test

test:
	# If testlib.so is statically compiled, testlib2.so shouldn't be required
	rm -f testlib2.so
	LD_LIBRARY_PATH=. ./do_test

clean:
	rm -f do_test libtestlib.so testlib2.o

.PHONY: all
.PHONY: clean
.PHONY: test
