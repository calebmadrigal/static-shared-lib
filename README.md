# static-shared-lib-example

An example of how to build a statically-linked shared (dynamic) linux library (.so).

Things to note:

* `do_test.main()` calls `libtestlib.do_test()` which calls `testlib2.square()`.
* `libtestlib.so` is statically compiled. It relies on `testlib2.o` for the `square()` function.
* Since `testlib.so` is statically compiled, we can delete `testlib2.o` and `do_test` still runs.

My goal was to have `testlib2` be a normal dynamic library (`.so`), however, I was unable to statically compile it into `libtestlib.so` without changing how testlib2 was compiled, so that it is just an unlinked object file.

### Usage

Build it:

    make

Run it:

    make test

This deletes `testlib2.o` and runs `do_test`.

### Seeing the static linking

You can see that `libtestlib.so` is statically linked against `testlib2.o` by running `ldd`:

    $ ldd libtestlib.so
        linux-vdso.so.1 =>  (0x00007fffa2ffc000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f23e0a52000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f23e1034000)

Also, note, however, that `testlib.so` is dynamically linked against glibc and a couple other libraries.

### Disassembly

I opened `libtestlib.so` in [Hopper disassembler](http://www.hopperapp.com/), and was able to see the `square` function from `testlib2.o` in it (along side `do_test`):

![libtestlib.so disassembled](https://raw.githubusercontent.com/calebmadrigal/static-shared-lib/master/testlib-so-disassembled.png)

