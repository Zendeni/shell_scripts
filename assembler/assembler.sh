#!/bin/bash

# Extract the filename without the extension
fileName="${1%%.*}"

# Assemble the source file into an object file using NASM
nasm -f elf64 "${fileName}.s"
if [ $? -ne 0 ]; then
    echo "Assembly failed"
    exit 1
fi

# Link the object file to create an executable
ld "${fileName}.o" -o "${fileName}"
if [ $? -ne 0 ]; then
    echo "Linking failed"
    exit 1
fi

# Check if the second argument is '-g' and run gdb or the executable accordingly
if [ "$2" == "-g" ]; then
    gdb -q "${fileName}"
else
    ./"${fileName}"
fi
