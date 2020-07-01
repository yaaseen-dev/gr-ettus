# Copyright 2011,2012 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Setup library
########################################################################
include(GrPlatform) #define LIB_SUFFIX

list(APPEND rfnoc_example_sources
)

set(rfnoc_example_sources "${rfnoc_example_sources}" PARENT_SCOPE)
if(NOT rfnoc_example_sources)
	MESSAGE(STATUS "No C++ sources... skipping lib/")
	return()
endif(NOT rfnoc_example_sources)

add_library(gnuradio-rfnoc_example SHARED ${rfnoc_example_sources})
target_link_libraries(gnuradio-rfnoc_example gnuradio::gnuradio-runtime gnuradio::gnuradio-ettus)
target_include_directories(gnuradio-rfnoc_example
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
    PUBLIC $<INSTALL_INTERFACE:include>
  )
set_target_properties(gnuradio-rfnoc_example PROPERTIES DEFINE_SYMBOL "gnuradio_rfnoc_example_EXPORTS")

if(APPLE)
    set_target_properties(gnuradio-rfnoc_example PROPERTIES
        INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}/lib"
    )
endif(APPLE)

########################################################################
# Install built library files
########################################################################
include(GrMiscUtils)
GR_LIBRARY_FOO(gnuradio-rfnoc_example)

########################################################################
# Build and register unit test
########################################################################
include(GrTest)

# If your unit tests require special include paths, add them here
#include_directories()
# List all files that contain Boost.UTF unit tests here
list(APPEND test_rfnoc_example_sources
)
# Anything we need to link to for the unit tests go here
list(APPEND GR_TEST_TARGET_DEPS gnuradio-rfnoc_example)

if(NOT test_rfnoc_example_sources)
    MESSAGE(STATUS "No C++ unit tests... skipping")
    return()
endif(NOT test_rfnoc_example_sources)

foreach(qa_file ${test_rfnoc_example_sources})
    GR_ADD_CPP_TEST("rfnoc_example_${qa_file}"
        ${CMAKE_CURRENT_SOURCE_DIR}/${qa_file}
    )
endforeach(qa_file)
