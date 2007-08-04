##### http://autoconf-archive.cryp.to/ac_raf_func_which_getservbyname_r.html
#
# SYNOPSIS
#
#   AC_raf_FUNC_WHICH_GETSERVBYNAME_R
#
# DESCRIPTION
#
#   Provides a test to determine the correct way to call
#   getservbyname_r:
#
#    - defines HAVE_FUNC_GETSERVBYNAME_R_6 if it needs 6 arguments (e.g linux)
#    - defines HAVE_FUNC_GETSERVBYNAME_R_5 if it needs 5 arguments (e.g. solaris)
#    - defines HAVE_FUNC_GETSERVBYNAME_R_4 if it needs 4 arguments (e.g. osf/1)
#
#   An example use can be found at
#   http://raf.org/autoconf/net_getservbyname.c
#
#   Based on Caolan McNamara's gethostbyname_r macro. Based on David
#   Arnold's autoconf suggestion in the threads faq.
#
# LAST MODIFICATION
#
#   2007-08-04
#
# COPYLEFT
#
#   Copyright (c) 2007 raf <raf@raf.org>
#
#   This program is free software: you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation, either version 3 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see
#   <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

AC_DEFUN([AC_raf_FUNC_WHICH_GETSERVBYNAME_R],
[AC_CACHE_CHECK(for getservbyname_r, ac_cv_func_which_getservbyname_r, [
AC_CHECK_FUNC(getservbyname_r, [
        AC_TRY_COMPILE([
#               include <netdb.h>
        ],      [

        char *name;
        char *proto;
        struct servent *se;
        struct servent_data data;
        (void) getservbyname_r(name, proto, se, &data);

                ],ac_cv_func_which_getservbyname_r=four,
                        [
  AC_TRY_COMPILE([
#   include <netdb.h>
  ], [
        char *name;
        char *proto;
        struct servent *se, *res;
        char buffer[2048];
        int buflen = 2048;
        (void) getservbyname_r(name, proto, se, buffer, buflen, &res)
  ],ac_cv_func_which_getservbyname_r=six,

  [
  AC_TRY_COMPILE([
#   include <netdb.h>
  ], [
        char *name;
        char *proto;
        struct servent *se;
        char buffer[2048];
        int buflen = 2048;
        (void) getservbyname_r(name, proto, se, buffer, buflen)
  ],ac_cv_func_which_getservbyname_r=five,ac_cv_func_which_getservbyname_r=no)

  ]

  )
                        ]
                )]
        ,ac_cv_func_which_getservbyname_r=no)])

if test $ac_cv_func_which_getservbyname_r = six; then
  AC_DEFINE(HAVE_FUNC_GETSERVBYNAME_R_6)
elif test $ac_cv_func_which_getservbyname_r = five; then
  AC_DEFINE(HAVE_FUNC_GETSERVBYNAME_R_5)
elif test $ac_cv_func_which_getservbyname_r = four; then
  AC_DEFINE(HAVE_FUNC_GETSERVBYNAME_R_4)

fi

])
