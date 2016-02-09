# static-shared-lib-example

An example of how to build a statically-linked shared (dynamic) linux library (.so).

Things to note:

* `do_test.main()` calls `testlib.do_test()` which calls `testlib2.square()`.
* `testlib.so` is statically compiled. It relies on `testlib2.so` for the `square()` function.
* Since `testlib.so` is statically compiled, we can delete `testlib2.so` and `do_test` still runs.

### Usage

Build it:

    make

Run it:

    make test

This deletes `testlib2.so` and runs `do_test`.

### Seeing the static linking

You can see that `testlib.so` is statically linked against `testlib2.so` by running `ldd`:

    $ ldd testlib.so
        linux-vdso.so.1 =>  (0x00007fffa2ffc000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f23e0a52000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f23e1034000)

Also, note, however, that `testlib.so` is dynamically linked against glibc and a couple other libraries.

### Disassembly

I opened `testlib.so` in [Hopper disassembler](http://www.hopperapp.com/), and was able to see the `square` function from `testlib2.so` in it (along side `do_test`):

![testlib.so disassembled](https://raw.githubusercontent.com/calebmadrigal/static-shared-lib/master/testlib-so-disassembled.png)

