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
# ecbuild_find_lexyacc
# ====================
#
# Find flex and bison (preferred) or lex and yacc.
#
# Input variables
# ---------------
#
# The following CMake variables can set to skip search for bison or yacc:
#
# :SKIP_BISON: do not search for flex and bison
# :SKIP_YACC:  do not search for lex and yacc
#
# Output variables
# ----------------
#
# The following CMake variables are set if flex and bison were found:
#
# :FLEX_FOUND:       flex was found
# :BISON_FOUND:      bison was found
# :FLEX_EXECUTABLE:  path to the flex executable
# :BISON_EXECUTABLE: path to the bison executable
#
# The following CMake variables are set if lex and yacc were found:
#
# :LEX_FOUND:       lex was found
# :YACC_FOUND:      yacc was found
# :LEX_EXECUTABLE:  path to the lex executable
# :YACC_EXECUTABLE: path to the yacc executable
#
##############################################################################

macro( ecbuild_find_lexyacc )

  # find preferably bison or else yacc

  if( NOT SKIP_BISON )

    find_package( BISON 2.3 )
    find_package( FLEX )

  endif()

  if( NOT BISON_FOUND AND NOT SKIP_YACC )

    find_package( YACC )
    find_package( LEX  )

  endif()

  if( NOT YACC_FOUND AND NOT BISON_FOUND ) # neither bison nor yacc were found
    message( FATAL_ERROR "neither bison or yacc were found - at least one is required (together with its lexical analyser" )
  endif()

  if( NOT YACC_FOUND ) # check for both bison & flex together
    if( BISON_FOUND AND NOT FLEX_FOUND )
      message( FATAL_ERROR "both bison and flex are required - flex not found" )
    endif()
    if( FLEX_FOUND AND NOT BISON_FOUND )
      message( FATAL_ERROR "both bison and flex are required - bison not found" )
    endif()
  endif()

  if( NOT BISON_FOUND ) # check for both yacc & lex together
    if( YACC_FOUND AND NOT LEX_FOUND )
      message( FATAL_ERROR "both yacc and lex are required - lex not found" )
    endif()
    if( LEX_FOUND AND NOT YACC_FOUND )
      message( FATAL_ERROR "both yacc and lex are required - yacc not found" )
    endif()
  endif()

endmacro( ecbuild_find_lexyacc )
