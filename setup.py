import os
import platform
from setuptools import setup, Extension
import numpy as np


system = platform.system()

lib = []
inc = [np.get_include()]
libdir = []
mac = []
data = []
if platform.system() == "Windows":
    inc += [os.path.join('qhy_sdk', 'pkg_win', 'include'), 'QHYCCD']
    lib += ["qhyccd"]
    if platform.architecture()[0] == "64bit":
        # lib += ["setupapi", "msvcrt", "ws2_32", "Advapi32"]
        libdir += [os.path.join('qhy_sdk', 'pkg_win', 'x64')]
        mac += [("_LIB", None)]
        data += [os.path.join('qhy_sdk', 'pkg_win', 'x64', 'qhyccd.dll')]
    elif platform.architecture()[0] == "32bit":
        libdir += [os.path.join('qhy_sdk', 'pkg_win', 'x86')]
        data += [os.path.join('qhy_sdk', 'pkg_win', 'x86', 'qhyccd.dll')]
elif platform.system() == "Linux":
    inc += ["/usr/local/include"]
    lib += ["qhyccd"]
    if platform.architecture()[0] == "64bit":
        lib += []
        libdir += ["/usr/local/lib"]
        mac += []
src = [os.path.join("QHYCCD", "pyqhyccd.pyx")]
compiler_settings = {
    'libraries': lib,
    'include_dirs': inc,
    'library_dirs': libdir,
    'define_macros': mac,
    'export_symbols': None,
    'language': 'c++'
}

ext_modules = [Extension('QHYCCD.pyqhyccd', src, **compiler_settings)]

setup(
    name="python-qhy",
    version="1.2",
    author="Fockez Zhang",
    author_email="fockez@live.com",
    download_url=" ",
    keywords=["QHY", "qhy"],
    description="Python Interface for QHY with ASCOM compatible API",
    packages=['QHYCCD'],
    package_dir={'QHYCCD': 'QHYCCD'},
    data_files=[(os.path.join('..', '..', 'QHYCCD'), data)],
    ext_modules=ext_modules,
    requires=['numpy (>=1.5)'],
    classifiers=[
        "Development Status :: 3 - Beta",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research",
        "License :: OSI Approved :: BSD License",
        "Operating System :: POSIX :: Linux",
        "Operating System :: Microsoft :: Windows",
        "Operating System :: Microsoft :: Windows :: Windows 10",
        "Programming Language :: Python :: 3",
        "Programming Language :: Cython",
        "Topic :: Scientific/Engineering",
        "Topic :: Scientific/Engineering :: Astronomy",
        "Topic :: Software Development :: Libraries :: Python Modules"
    ],
    long_description="""
    This package supplies ASCOM compatible API of Pyhton for the QHY 
    camera on Linux and Windows, to meet the performance for 
    camera image aquisition in Python.
    """
)
