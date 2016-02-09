all: do_test

testlib2.so: testlib2.c testlib2.h
	gcc -c -fPIC testlib2.c -o testlib2.so

testlib.so: testlib2.so testlib.c testlib.h
	gcc -fPIC testlib.c testlib2.so -static -shared -o testlib.so -lc

do_test: testlib.so testlib2.so
	gcc -fPIC do_test.c testlib.so testlib2.so -o do_test

test:
	# If testlib.so is statically compiled, testlib2.so shouldn't be required
	rm -f testlib2.so
	LD_LIBRARY_PATH=. ./do_test

clean:
	rm -f do_test testlib.so testlib2.so

.PHONY: all
.PHONY: clean
.PHONY: test
