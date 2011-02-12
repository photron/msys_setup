#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <malloc.h>
#include <string.h>

struct rewrite {
    const char *from;
    const char *to;
    size_t length;
};

struct rewrite rewrites[] = {
    { "python26", "python27", 8 },
    { "_26_python_", "_27_python_", 11 }
};

int
main(int argc, char **argv)
{
    char *path;
    struct stat st;
    char *buffer;
    FILE *fp;
    int i, k;
    int rewrites_count = sizeof (rewrites) / sizeof (struct rewrite);

    if (argc != 2) {
        printf("usage: %s <libvirtmod.pyd>", argv[0]);
        return 1;
    }

    path = argv[1];

    if (stat(path, &st) < 0) {
        printf("error: could not stat '%s'\n", path);
        return 1;
    }

    buffer = malloc(st.st_size + 1024);
    fp = fopen(path, "rb");

    if (fp == NULL) {
        printf("error: could not open '%s' for reading\n", path);
        return 1;
    }

    if (fread(buffer, 1, st.st_size, fp) != st.st_size) {
        fclose(fp);
        free(buffer);
        printf("error: could not read from '%s'\n", path);
        return 1;
    }

    fclose(fp);

    for (i = 0; i < st.st_size - 100; ++i) {
        for (k = 0; k < rewrites_count; ++k) {
            if (memcmp(buffer + i, rewrites[k].from, rewrites[k].length) == 0) {
                printf("rewriting '%s' at 0x%08x\n", rewrites[k].from, i);

                memcpy(buffer + i, rewrites[k].to, rewrites[k].length);
                i += rewrites[k].length;
            }
        }
    }

    fp = fopen(path, "wb");

    if (fp == NULL) {
        free(buffer);
        printf("error: could not open '%s' for writing\n", path);
        return 1;
    }

    if (fwrite(buffer, 1, st.st_size, fp) != st.st_size) {
        fclose(fp);
        free(buffer);
        printf("error: could not write to '%s'\n", path);
        return 1;
    }

    fclose(fp);
    free(buffer);

    return 0;
}
