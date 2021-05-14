#! /bin/bash

clang -S -emit-llvm test.c   # Generates readable LLVM IR code
opt -O1 -S test.ll -o new.ll # Transforms code, generate new readable LLVM IR

llc new.ll                   # Compiles LLVM IR to assembly code
gcc -o test new.s            # Links, etc, generates object code

# Applying loop unrolling
opt -loops -loop-rotate -loop-simplify -loop-unroll -unroll-count=3 -unroll-allow-partial -S test.ll -o new.ll
