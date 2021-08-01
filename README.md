# rsync4python
Performant Python Rsync using Cython

Idea was to put a very simple wrapper around librsync so it could be used natively from within Python.

NOTE: The original code was targetting Python 3.4 which provided to not work b/c the underlying file
	object was not available. As of Python 3.8 this seems to have changed and is now working again,
	at least for the unit tests. YMMV; please file a bug if it fails.


# Usage

This is a very simple wrapper around librsync that utilizes files to transfer the data.
This functionality can generate an Rsync Signature and use an Rsync Patch at a basic level.
Not all Rsync Options are presently supported (PRs welcome).

NOTE: This was originally written for a Cloud-based Rsync-As-A-Service service so it was kept minimal;
	Changes are certainly welcome if more features are needed or bugs found.

NOTE: The APIs are time-consuming functionality. You will want to wrap the calls with some form of asynchronicity.
	In Python2 use gevents/eventlet. In Python3 look at using asyncio to spin off separate threads that can be waited on.

## Signature

The Rsync Signature is generated simply as follows:

	with open("somefile", "r") as input_data:
		with open("somefile.sig", "w") as signature_data:
			rsync4python.signature(input_data, signature_data)

This will process the input data through librsync to generate the RSync Signature and store it into
the signature data file.

## Patch

The Rsync Patch function is used as follows:

	with open("somefile.sig", "r") as signature_data:
		with open("somefile.delta", "r") as patch_data:
			with open("somenewfile", "w") as output_data:
				rsync4python.patch(signature_data, patch_data, output_data)

## RDiff

The RDiff submodule provides a simple interface for each of the above functions using the file names:

### Signature

	rsync4python.rdiff.rdiff_signature("somefile", "somefile.sig")

### Patch

	rsync4python.rdiff.rdiff_patch("somefile.sig", "somefile.delta", "somenewfile")
