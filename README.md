# rsync4python
Performant Python Rsync using Cython

Idea was to put a very simple wrapper around librsync so it could be used natively from within Python.
As I was targetting Python3, this proved to be fruitless since Python3 doesn't have support for getting
C API FILE* (C File Streams) from a Python3 File Object. :(

Otherwise, it'd be a very nice easy thing to do!
