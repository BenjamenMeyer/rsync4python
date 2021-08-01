"""
rsync4python - C Interface
"""
cimport librsync
cimport libcext

__RSYNC_VERSION_MAJOR=0
__RSYNC_VERSION_MINOR=9
__RSYNC_VERSION_UPDATE=7

RSYNC_VERSION=(__RSYNC_VERSION_MAJOR,
               __RSYNC_VERSION_MINOR,
               __RSYNC_VERSION_UPDATE)


cdef class __file_manager:
    cdef object filestream
    cdef int old_fd
    cdef int new_fd

    def __cinit__(self, filestream):
        self.filestream = filestream
        self.old_fd = self.filestream.fileno()
        self.new_fd = libcext.dup(self.old_fd)

    def __dealloc__(self):
        libcext.close(self.new_fd)

        self.filestream = None
        self.old_fd = 0
        self.new_fd = 0


RS_BLAKE2_SIG_MAGIC = 0x72730137

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
        b = __file_manager(base)
        s = __file_manager(signature)
        cdef libcext.FILE* base_file = libcext.fdopen(b.new_fd, b.filestream.mode.encode())
        cdef libcext.FILE* sig_file = libcext.fdopen(s.new_fd, s.filestream.mode.encode())
        result = librsync.rs_sig_file(base_file,
                                      sig_file,
                                      block_len,
                                      strong_len,
                                      RS_BLAKE2_SIG_MAGIC,
                                      NULL)
        libcext.fclose(sig_file)
        libcext.fclose(base_file)
        del s
        del b


    @staticmethod
    def patch(base, delta, baseplusdelta):
        # stats = librsync.rs_stats_t
        b = __file_manager(base)
        d = __file_manager(delta)
        bpd = __file_manager(baseplusdelta)
        cdef libcext.FILE* base_file = libcext.fdopen(b.new_fd, b.filestream.mode.encode())
        cdef libcext.FILE* delta_file = libcext.fdopen(d.new_fd, d.filestream.mode.encode())
        cdef libcext.FILE* baseplusdelta_file = libcext.fdopen(bpd.new_fd, bpd.filestream.mode.encode())
        result = librsync.rs_patch_file(base_file,
                                        delta_file,
                                        baseplusdelta_file,
                                        NULL)
        libcext.fclose(baseplusdelta_file)
        libcext.fclose(delta_file)
        libcext.fclose(base_file)
        del bpd
        del d
        del b
