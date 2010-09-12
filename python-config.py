#!/usr/bin/python

import sys
import os
import getopt
from distutils import sysconfig

CFLAGS = '-fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes'
LIBS = ''
SYSLIBS = ''
Py_ENABLE_SHARED = False
LIBPL = sysconfig.PREFIX + '/libs'

valid_opts = ['prefix', 'exec-prefix', 'includes', 'libs', 'cflags', 
              'ldflags', 'help']

def exit_with_usage(code=1):
    print >>sys.stderr, "Usage: %s [%s]" % (sys.argv[0], 
                                            '|'.join('--'+opt for opt in valid_opts))
    sys.exit(code)

try:
    opts, args = getopt.getopt(sys.argv[1:], '', valid_opts)
except getopt.error:
    exit_with_usage()

if not opts:
    exit_with_usage()

opt = opts[0][0]

pyver = sysconfig.get_config_var('VERSION')
getvar = sysconfig.get_config_var

if opt == '--help':
    exit_with_usage(0)

elif opt == '--prefix':
    print sysconfig.PREFIX.replace('\\', '/')

elif opt == '--exec-prefix':
    print sysconfig.EXEC_PREFIX.replace('\\', '/')

elif opt in ('--includes', '--cflags'):
    flags = ['-I' + sysconfig.get_python_inc(),
             '-I' + sysconfig.get_python_inc(plat_specific=True)]
    if opt == '--cflags':
        flags.extend(CFLAGS.split())
    print ' '.join(flags).replace('\\', '/')

elif opt in ('--libs', '--ldflags'):
    libs = LIBS.split() + SYSLIBS.split()
    libs.append('-lpython' + pyver)
    # add the prefix/lib/pythonX.Y/config dir, but only if there is no
    # shared library in prefix/lib/.
    if opt == '--ldflags' and not Py_ENABLE_SHARED:
        libs.insert(0, '-L' + LIBPL)
    print ' '.join(libs).replace('\\', '/')
