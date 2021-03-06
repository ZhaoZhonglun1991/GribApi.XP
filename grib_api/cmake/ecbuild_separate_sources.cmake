# (C) Copyright 1996-2015 ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

##############################################################################
#.rst:
#
# ecbuild_separate_sources
# ========================
#
# Separate a given list of sources according to language. ::
#
#   ecbuild_separate_sources( TARGET <name>
#                             SOURCES <source1> [ <source2> ... ] )
#
# Options
# -------
#
# TARGET : required
#   base name for the CMake output variables to set
#
# SOURCES : required
#   list of source files to separate
#
# Output variables
# ----------------
#
# If any file of the following group of extensions is present in the list of
# sources, the corresponding CMake variable is set:
#
# :<target>_h_srcs:   list of sources with extension .h, .hxx, .hh, .hpp, .H
# :<target>_c_srcs:   list of sources with extension .c
# :<target>_cxx_srcs: list of sources with extension .cc, .cxx, .cpp, .C
# :<target>_f_srcs:   list of sources with extension .f, .F, .for, f77, .f90, .f95
#
##############################################################################

macro( ecbuild_separate_sources )

	set( options )
	set( single_value_args TARGET  )
	set( multi_value_args  SOURCES )

	cmake_parse_arguments( _PAR "${options}" "${single_value_args}" "${multi_value_args}"  ${_FIRST_ARG} ${ARGN} )

	if(_PAR_UNPARSED_ARGUMENTS)
	  message(FATAL_ERROR "Unknown keywords given to ecbuild_separate_sources(): \"${_PAR_UNPARSED_ARGUMENTS}\"")
	endif()

	if( NOT _PAR_TARGET  )
	  message(FATAL_ERROR "The call to ecbuild_separate_sources() doesn't specify the TARGET.")
	endif()

	if( NOT _PAR_SOURCES )
	  message(FATAL_ERROR "The call to ecbuild_separate_sources() doesn't specify the SOURCES.")
	endif()

	foreach( src ${_PAR_SOURCES} )
		if(${src} MATCHES "(\\.h|\\.hxx|\\.hh|\\.hpp|\\.H)")
			list( APPEND ${_PAR_TARGET}_h_srcs ${src} )
		endif()
	endforeach()

	foreach( src ${_PAR_SOURCES} )
		if(${src} MATCHES "(\\.c)")
			list( APPEND ${_PAR_TARGET}_c_srcs ${src} )
		endif()
	endforeach()

	foreach( src ${_PAR_SOURCES} )
		if(${src} MATCHES "(\\.cc|\\.cxx|\\.cpp|\\.C)")
			list( APPEND ${_PAR_TARGET}_cxx_srcs ${src} )
		endif()
	endforeach()

	foreach( src ${_PAR_SOURCES} )
		if(${src} MATCHES "(\\.f|\\.F|\\.for|\\.f77|\\.f90|\\.f95)")
			list( APPEND ${_PAR_TARGET}_f_srcs ${src} )
		endif()
	endforeach()

#    debug_var( ${_PAR_TARGET}_h_srcs )
#    debug_var( ${_PAR_TARGET}_c_srcs )
#    debug_var( ${_PAR_TARGET}_cxx_srcs )
#    debug_var( ${_PAR_TARGET}_f_srcs )

endmacro( ecbuild_separate_sources  )
