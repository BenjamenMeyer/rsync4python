cdef extern from "librsync.h":
    cdef enum rs_result "rs_result":
        RS_DONE = 0  # Completed successfully
        RS_BLOCKED = 1  # Blocked waiting for more data
        RS_RUNNING = 2  # Not yet finished or blocked; this value should never be returned to caller
        RS_TEST_SKIPPED = 77  # Test neither passed or failed
        RS_IO_ERROR = 100  # Error in file or network IO
        RS_SYNTAX_ERROR = 101  # command-line syntax error
        RS_MEM_ERROR = 102  # out of memory
        RS_INPUT_ENDED = 103  # end of input file, possibly unexpected
        RS_BAD_MAGIC = 104  # bad magic number at start of stream
                            # probably not a librsync file or possibly the
                            # wrong kind of file or from an incompatible library version
        RS_UNIMPLEMENTED = 105  # librsync author was lazy
        RS_CORRUPT = 106  # unbelievable value in stream
        RS_INTERNAL_ERROR = 107  # probably a librsync library bug
        RS_PARAM_ERROR = 108  # bad value passed in to libray
                              # probably an application bug

    ctypedef long rs_long_t
    # cdef long rs_long_t
    cdef struct rs_signature_t
    cdef struct rs_stats_t
    cdef struct FILE

    rs_result rs_sig_file(FILE *in_file, FILE* sig_file, size_t block_len, size_t strong_len, rs_stats_t* stats)
    rs_result rs_loadsig_file(FILE *, rs_signature_t **, rs_stats_t *)
    rs_result rs_file_copy_cb(void* arg, rs_long_t pos, size_t *len, void **buf)
    rs_result rs_delta_file(rs_signature_t *, FILE *new_file, FILE *delta_file, rs_stats_t *)
    rs_result rs_patch_file(FILE *basis_file, FILE *delta_file, FILE *new_file, rs_stats_t *)
