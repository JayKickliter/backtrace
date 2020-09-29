##########################################################################
# Project Setup                                                          #
##########################################################################
# Setup differs on whether or not we're being built as a standalone
# project or as subproject.
if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  # We're building as a standalone project.
  cmake_minimum_required(VERSION 3.1)
  set(CMAKE_C_STANDARD 11)
  set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
  set(CMAKE_SYSTEM_NAME Generic)
  set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
  project(Backtrace C)
  set(BACKTRACE_IS_STANDALONE TRUE)
  option(BUILD_EXAMPLES "Build example applications" TRUE)
else()
  # Some other cmake project has included us as a subproject,
  # i.e. `include(path/to/backtrace/CMakeLists.txt)` where
  # `CMakeLists.txt` is this file.
  set(BACKTRACE_IS_STANDALONE FALSE)
endif()


##########################################################################
# Static Analysis                                                        #
##########################################################################
if(CMAKE_VERSION VERSION_GREATER 3.9 AND BACKTRACE_IS_STANDALONE)
  find_program(CPPCHECK
    NAMES cppcheck
    DOC   "Path to cppcheck executable"
    )
  if(CPPCHECK)
    message(STATUS "Found cppcheck: ${CPPCHECK}")
    set(CMAKE_C_CPPCHECK ${CPPCHECK}
      --enable=warning,style
      --inconclusive
      --inline-suppr
      --quiet
      --std=c${CMAKE_C_STANDARD}
      --suppress=missingInclude
      --template=gcc
      )
  endif(CPPCHECK)
endif()


##########################################################################
# Library                                                                #
##########################################################################
add_library(backtrace
  backtrace/backtrace.c
  )

target_include_directories(backtrace
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
  $<INSTALL_INTERFACE:include>
  )

target_compile_options(backtrace
  PUBLIC
  -fno-omit-frame-pointer
  -funwind-tables
  -mcpu=cortex-m3
  -mthumb
  -nostdlib
  )

if (CMAKE_C_COMPILER_ID MATCHES "(Apple)?Clang")
  target_compile_options(backtrace
    PUBLIC
    --target=arm-none-eabi
    )
elseif (CMAKE_C_COMPILER_ID MATCHES "GNU")
  target_compile_options(backtrace
    PUBLIC
    # Write the name of each function into the text section, directly
    # preceding the function prologue.
    -mpoke-function-name
    )
endif()


##########################################################################
# Optional Targets                                                       #
##########################################################################
if(BUILD_EXAMPLES)
  add_subdirectory(samples)
endif()
