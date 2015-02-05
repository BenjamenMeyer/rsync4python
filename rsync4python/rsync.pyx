"""
rsync4python - C Interface
"""
cimport librsync

__RSYNC_VERSION_MAJOR=0
__RSYNC_VERSION_MINOR=9
__RSYNC_VERSION_UPDATE=7

RSYNC_VERSION=(__RSYNC_VERSION_MAJOR,
               __RSYNC_VERSION_MINOR,
               __RSYNC_VERSION_UPDATE)


cdef extern from "Python.h":
    ctypedef struct FILE
    FILE* PyFile_AsFile(object)


cdef class rsync:

    def __cinit__(self):
        pass

    def __dealloc__(self):
        pass


    @staticmethod
    def signature(base, signature):

        # stats = librsync.rs_stats_t
        # block_len = librsync.RS_DEFAULT_BLOCK_LEN
        # strong_len = librsync.RS_DEFAULT_STRONG_LEN
        block_len = 2048
        strong_len = 8
        result = librsync.rs_sig_file(PyFile_AsFile(base),
                                      PyFile_AsFile(signature),
                                      rsync.block_len,
                                      rsync.strong_len,
                                      NULL)


    @staticmethod
    def patch(base, delta, result):
        # stats = librsync.rs_stats_t
        result = librsync.rs_patch_file(PyFile_AsFile(base),
                                        PyFile_AsFile(delta),
                                        PyFile_AsFile(result),
                                        NULL)
