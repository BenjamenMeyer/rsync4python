cdef extern from "stdio.h":
    cdef struct FILE

cdef extern from "librsync.h":
    ctypedef struct rsync

    # cdef enum rs_result "rs_result":
    ctypedef int rs_magic_number

    # cdef RS_DEFAULT_BLOCK_LEN = 2048
    # cdef RS_DEFAULT_STRONG_LEN = 8
    ctypedef int rs_result
    ctypedef long rs_long_t
    # cdef long rs_long_t
    cdef struct rs_signature_t
    cdef struct rs_stats_t

    rs_result rs_sig_file(FILE *old_file, FILE* sig_file, size_t block_len, size_t strong_len, rs_magic_number sig_magic, rs_stats_t* stats)
    rs_result rs_loadsig_file(FILE *, rs_signature_t **, rs_stats_t *)
    rs_result rs_file_copy_cb(void* arg, rs_long_t pos, size_t *len, void **buf)
    rs_result rs_delta_file(rs_signature_t *, FILE *new_file, FILE *delta_file, rs_stats_t *)
    rs_result rs_patch_file(FILE *basis_file, FILE *delta_file, FILE *new_file, rs_stats_t *)
