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

### Disassembly

I opened `testlib.so` in [Hopper disassembler](http://www.hopperapp.com/), and was able to see the `square` function from `testlib2.so` in it (along side `do_test`):

![testlib.so disassembled](https://raw.githubusercontent.com/calebmadrigal/static-shared-lib/master/testlib-so-disassembled.png)

