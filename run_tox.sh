#!/bin/bash

RUNTOX_ENV_DIR=.runtox_env

for arg in ${@}
do
	case "${arg}" in
		"-r")
			RUNTOX_ENV_DESTROY=1
			;;
		"--recreate")
			RUNTOX_ENV_DESTROY=1
			;;
		*)
			# Do nothing
			;;
	esac
done

if [ -v RUNTOX_ENV_DESTROY ]; then
	rm -Rf ${RUNTOX_ENV_DIR}

fi

if [ ! -d ${RUNTOX_ENV_DIR} ]; then
	virtualenv -p `which python3` ${RUNTOX_ENV_DIR}
	RUNTOX_ENV_INSTALL_CYTHON=1
fi

source ${RUNTOX_ENV_DIR}/bin/activate

if [ -v RUNTOX_ENV_INSTALL_CYTHON ]; then
	pip install Cython
	unset RUNTOX_ENV_INSTALL_CYTHON
fi

python setup.py build_ext --inplace
tox --installpkg=. ${@}
