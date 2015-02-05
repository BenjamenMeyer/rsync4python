import glob
import os
from os import path
from setuptools import setup, find_packages, Extension
import sys
# from Cython.Build import cythonize

MYDIR = path.abspath(os.path.dirname(__file__))
REQUIRES = ['cython']
DESCRIPTION = 'rsync access for python'

try:
    from Cython.Distutils import build_ext
except ImportError:
    print('\nFAILED: Cython not currently installed')
    sys.exit(1)

def list_modules(dirname):
    filenames = glob.glob(path.join(dirname, '*.py'))

    module_names = []
    for name in filenames:
        module, ext = path.splitext(path.basename(name))
        if module != '__init__':
            module_names.append(module)

    return module_names

ext_modules = [
    Extension('rsync4python.' + ext, [path.join('rsync4python', ext + '.py')])
    for ext in list_modules(path.join(MYDIR, 'rsync4python'))]

cmdclass = {'build_ext': build_ext}

setup(
    name='rsync4python',
    version='0.1',
    description='rsync4python - {0}'.format(DESCRIPTION),
    license='Apache License 2.0',
    url='https://github.com/BenjamenMeyer/rsync4python',
    author='Rackspace',
    author_email='ben.meyer@rackspace.com',
    install_requires=REQUIRES,
    test_suite='rsync4python',
    zip_safe=False,
    packages=find_packages(exclude=['test*',
                                    'rsync4python/tests*']),
    cmdclass=cmdclass,
    ext_modules=ext_modules
)
