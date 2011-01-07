#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <malloc.h>
#include <string.h>

int
main(int argc, char **argv)
{
    char *path;
    int path_length;
    int imports_count;
    char **imports;
    int *imports_lengths;
    struct stat st;
    char *buffer;
    FILE *fp;
    int i, k;
    const char *prefix = "_lv_"; // must not be longer than 4 byte
    int prefix_length = strlen(prefix);

    if (argc < 3) {
        printf("usage: %s <dll> <import>...", argv[0]);
        return 1;
    }

    path = argv[1];
    path_length = strlen(path);
    imports_count = argc - 2;
    imports = malloc(imports_count * sizeof (char *));
    imports_lengths = malloc(imports_count * sizeof (int));

    for (i = 2, k = 0; i < argc; ++i) {
        if (path_length >= strlen(argv[i]) &&
            strcmp(path + path_length - strlen(argv[i]), argv[i]) == 0) {
            /* skip self */
            --imports_count;
            continue;
        }
        
        imports[k] = argv[i];
        imports_lengths[k] = strlen(argv[i]);

        ++k;
    }

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
        for (k = 0; k < imports_count; ++k) {
            if (memcmp(buffer + i, imports[k], imports_lengths[k]) == 0) {
                if (i > prefix_length &&
                    memcmp(buffer + i - prefix_length, prefix,
                           prefix_length) == 0) {
                    /* don't rewrite again */
                    printf("ignoring already rewritten '%s' at 0x%08x\n",
                           imports[k], i);
                    continue;
                }

                printf("rewriting '%s' at 0x%08x\n", imports[k], i);

                memcpy(buffer + i, prefix, prefix_length);
                i += prefix_length;

                memcpy(buffer + i, imports[k], imports_lengths[k]);
                i += imports_lengths[k];

                memcpy(buffer + i, "\0\0\0", 3);
                i += 3;
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
