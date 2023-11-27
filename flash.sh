#!/bin/bash 
export ok=0
while : ; do  make -foled_test.mk flash && ok=1
if [ "$ok" -eq 1 ]; then  break; fi;
sleep 1;
done
