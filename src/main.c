/*
Copyright (c) 2025, Kacper Dziadek
License is found in ./LICENSE
*/

#include <stdio.h>
#include <stdlib.h>

#define VERSION "1.0"

const char* getenv_or(const char* var, const char* other);

int main(const int argc, const char* argv[]) {
    if (argc < 2) {
        puts("Hello world!");
        return 0;
    }
    switch (argv[1][0]) {
        case 'v':
            printf("Version: %s\n", VERSION);
            return 0;
        default:
            printf("example [v]");
            return 1;
    }
    return 0;
}

const char* getenv_or(const char* var, const char* other) {
    const char* env = getenv(var);
    if (!env) {
        return other;
    }
    return env;
}
