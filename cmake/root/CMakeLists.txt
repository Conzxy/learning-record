cmake_minimum_required(VERSION 3.10)
# Generate compile_commands.json
# to make clangd works.
# !WARNING
# This only useful for `Ninja` and `Makefile` generator
# For other generator, CMake ignore it, i.e., do nothing.
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# Include useful module
include(cmake/utils.cmake)
#include(cmake/compile_flag.cmake)
#include(cmake/build_type.cmake)
#include(cmake/cache_var.cmake)
#include(cmake/platform.cmake)
#include(cmake/install.cmake)

# Extract the version from version.h in the top level of include directory
kanon_extract_version()

project(kanon VERSION ${KANON_VERSION})
message(STATUS "Building kanon: ${KANON_VERSION}")

#add_subdirectory(third-party)
# Add source directory before install
add_subdirectory(kanon)

if (KANON_INSTALL)
  set(kanon_export_targets )
  conzxy_install(PROJECT kanon NAMESPACE kanon TARGETS ${kanon_export_targets})
endif ()
