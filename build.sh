#!/bin/bash 

# usage:
# ./build.sh  [flash]
# flash after build 

    make 
    if [[ ! -z $1 && ($1 == "flash") ]]; then 
        make flash 
    fi 
