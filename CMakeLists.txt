cmake_minimum_required (VERSION 3.10)

project(stevie LANGUAGES C ASM VERSION 0.1.0)

enable_language(ASM)

set (TARGET stevie.ttp)

set (SOURCES main.c edit.c linefunc.c normal.c cmdline.c hexchars.c
        misccmds.c help.c ptrfunc.c search.c alloc.c
        mark.c screen.c fileio.c param.c
        regexp.c regsub.c tos.c font.s)

set (CRT0 /opt/cross-mint/m68k-atari-mint/sys-root/usr/lib/crt0.o)

add_executable(${TARGET} ${SOURCES})

#target_compile_options(${TARGET} PUBLIC -std=c99 -O2 -pedantic -Wall -Wextra -Wstrict-prototypes -Wno-unused-parameter)
target_include_directories(${TARGET} SYSTEM PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_directories(${TARGET} PUBLIC /opt/cross-mint/lib/gcc/m68k-atari-mint/4.6.4)
target_link_libraries(${TARGET} PUBLIC gcc c gcc)
target_link_options(${TARGET} PUBLIC LINKER:-Map=${CMAKE_BINARY_DIR}/stevie.map)
