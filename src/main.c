/*
Copyright (c) 2025, Kacper Dziadek
License is found in ./LICENSE
*/

#include <stdio.h>
#include <stdlib.h>

const char* getenv_or(const char* var, const char* other);

int main(void) {
    const char* cc = getenv_or("CC","/usr/bin/clang");
    printf("Using cc: %s\n", cc);
    puts("Hello world");
    return 0;
}

const char* getenv_or(const char* var, const char* other) {
    const char* env = getenv(var);
    if (!env) {
        return other;
    }
    return env;
}
