cdef extern from "stdio.h":
    ctypedef struct FILE

    int dup(int oldfd)
    int close(int fd)
    FILE *fdopen(int fd, const char* mode)
    int fclose(FILE* fp)

