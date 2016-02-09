#include <stdio.h>
#include "testlib.h"
#include "testlib2.h"

int do_test(int num) {
    int num_squared = square(num);
    int i;
    for (i = 0; i < num_squared; i++) {
        printf("%d Hello\n", i+1);
    }
    return num;
}

