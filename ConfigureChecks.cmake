include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckIncludeFiles)
include(CheckSymbolExists)
include(CheckFunctionExists)
include(CheckLibraryExists)
include(CheckPrototypeExists)
include(CheckTypeSize)
include(MacroBoolTo01)

# The FindKDE4.cmake module sets _KDE4_PLATFORM_DEFINITIONS with
# definitions like _GNU_SOURCE that are needed on each platform.
set(CMAKE_REQUIRED_DEFINITIONS ${_KDE4_PLATFORM_DEFINITIONS})

macro_bool_to_01(ZLIB_FOUND HAVE_LIBZ)
macro_bool_to_01(JPEG_FOUND HAVE_LIBJPEG)
macro_bool_to_01(PNG_FOUND HAVE_LIBPNG)
macro_bool_to_01(TIFF_FOUND HAVE_LIBTIFF)
macro_bool_to_01(OPENEXR_FOUND HAVE_EXR)
macro_bool_to_01(X11_Xshape_FOUND HAVE_X11_EXTENSIONS_SHAPE_H)


if(BZIP2_FOUND)
   set(HAVE_BZIP2_SUPPORT 1)
   if(BZIP2_NEED_PREFIX)
      set(NEED_BZ2_PREFIX 1)
   endif(BZIP2_NEED_PREFIX)
else(BZIP2_FOUND)
   set(HAVE_BZIP2_SUPPORT 0)
endif(BZIP2_FOUND)
macro_bool_to_01(LIBART_FOUND HAVE_LIBART)
macro_bool_to_01(CARBON_FOUND HAVE_CARBON)


#now check for dlfcn.h using the cmake supplied CHECK_include_FILE() macro
# If definitions like -D_GNU_SOURCE are needed for these checks they
# should be added to _KDE4_PLATFORM_DEFINITIONS when it is originally
# defined outside this file.  Here we include these definitions in
# CMAKE_REQUIRED_DEFINITIONS so they will be included in the build of
# checks below.
set(CMAKE_REQUIRED_DEFINITIONS ${_KDE4_PLATFORM_DEFINITIONS})
if (WIN32)
   set(CMAKE_REQUIRED_LIBRARIES ${KDEWIN32_LIBRARIES} )
   set(CMAKE_REQUIRED_INCLUDES  ${KDEWIN32_INCLUDES} )
endif (WIN32)

check_include_files(dlfcn.h HAVE_DLFCN_H)
check_include_files(crt_externs.h HAVE_CRT_EXTERNS_H)
check_include_files(dirent.h HAVE_DIRENT_H)
check_include_files(inttypes.h HAVE_INTTYPES_H)
check_include_files(memory.h HAVE_MEMORY_H)
check_include_files(stdint.h HAVE_STDINT_H)
check_include_files(stdlib.h HAVE_STDLIB_H)
check_include_files(strings.h HAVE_STRINGS_H)
check_include_files(string.h HAVE_STRING_H)
check_include_files(sys/bitypes.h HAVE_SYS_BITYPES_H)
check_include_files(sys/stat.h HAVE_SYS_STAT_H)
check_include_files(sys/types.h HAVE_SYS_TYPES_H)
check_include_files(unistd.h HAVE_UNISTD_H)
check_include_files(fcntl.h HAVE_FCNTL_H)
check_include_files(iconv.h HAVE_ICONV_H)
check_include_files(limits.h      HAVE_LIMITS_H)
check_include_files(ndir.h        HAVE_NDIR_H)
check_include_files(paper.h HAVE_PAPER_H)
check_include_files(paths.h       HAVE_PATHS_H)
check_include_file_cxx(sstream HAVE_SSTREAM)
check_include_files(sys/dir.h     HAVE_SYS_DIR_H)
check_include_files(sys/ipc.h HAVE_SYS_IPC_H)
check_include_files("sys/types.h;sys/mman.h" HAVE_SYS_MMAN_H)
check_include_files(sys/ndir.h    HAVE_SYS_NDIR_H)
check_include_files(sys/params.h HAVE_SYS_PARAMS_H)
check_include_files(sys/shm.h HAVE_SYS_SHM_H)
check_include_files(sys/time.h    HAVE_SYS_TIME_H)
check_include_files(sys/wait.h HAVE_SYS_WAIT_H)
check_include_files(wchar.h HAVE_WCHAR_H)
check_include_files(wctype.h HAVE_WCTYPE_H)
check_include_files(vfork.h HAVE_VFORK_H)

check_function_exists(mkstemp    HAVE_MKSTEMP)
check_function_exists(mkstemps   HAVE_MKSTEMPS)

check_library_exists(crypt crypt "" HAVE_CRYPT)

check_function_exists(_NSGetEnviron   HAVE_NSGETENVIRON)
check_function_exists(initgroups HAVE_INITGROUPS)
check_function_exists(getpagesize HAVE_GETPAGESIZE)
check_function_exists(mmap            HAVE_MMAP)
check_function_exists(setenv     HAVE_SETENV)
check_function_exists(unsetenv   HAVE_UNSETENV)
check_function_exists(usleep     HAVE_USLEEP)

check_symbol_exists(gethostname     "unistd.h"                 HAVE_GETHOSTNAME)
check_symbol_exists(iswspace "wctype.h" HAVE_ISWSPACE)
check_symbol_exists(res_init        "sys/types.h;netinet/in.h;arpa/nameser.h;resolv.h" HAVE_RES_INIT)
check_symbol_exists(snprintf        "stdio.h"                  HAVE_SNPRINTF)
check_symbol_exists(vsnprintf       "stdio.h"                  HAVE_VSNPRINTF)

check_prototype_exists(res_init "sys/types.h;netinet/in.h;arpa/nameser.h;resolv.h" HAVE_RES_INIT_PROTO)
check_prototype_exists(initgroups "unistd.h;sys/types.h;unistd.h;grp.h" HAVE_INITGROUPS_PROTO)
check_prototype_exists(setenv stdlib.h HAVE_SETENV_PROTO)
check_prototype_exists(mkstemps "stdlib.h;unistd.h" HAVE_MKSTEMPS_PROTO)
check_prototype_exists(unsetenv stdlib.h HAVE_UNSETENV_PROTO)
check_prototype_exists(usleep unistd.h HAVE_USLEEP_PROTO)

check_type_size("int" SIZEOF_INT)
check_type_size("char *"  SIZEOF_CHAR_P)
check_type_size("long" SIZEOF_LONG)
check_type_size("short" SIZEOF_SHORT)
check_type_size("size_t" SIZEOF_SIZE_T)
check_type_size("unsigned long" SIZEOF_UNSIGNED_LONG)

