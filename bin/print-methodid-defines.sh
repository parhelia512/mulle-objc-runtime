#! /bin/sh

EXE="${1:-mulle-objc-uniqueid}"

METHODS="alloc
autorelease
class
copy
dealloc
finalize
initialize
init
instantiate
load
release
retain
forward:
dependencies"


for i in ${METHODS}
do
   value="`${EXE} "$i"`" || exit 1

   upcase="`echo "${i}" | tr '[a-z]' '[A-Z]'`"
   upcase="`echo "${upcase}" | sed 's/:/_/g'`"
   upcase="`echo "${upcase}" | sed 's/_*$//g'`"

   echo "#define MULLE_OBJC_${upcase}_METHODID ;MULLE_OBJC_METHODID( 0x${value}) ;// \"${i}\""
done | sort \
     | column -t -s ';'
