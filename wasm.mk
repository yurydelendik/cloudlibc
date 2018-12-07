WC = $(HOME)/Work/wasmception
CABI = ./cloudabi

default:
	CC=$(WC)/dist/bin/clang AR=$(WC)/dist/bin/llvm-ar \
	CFLAGS="--target=wasm32-unknown-unknown-wasm --sysroot=$(WC)/sysroot -D__wasm__ -D__CloudABI__ -DCRT1 -I$(CABI)/headers -g" \
	./build notests

install:
	PREFIX=`pwd`/_sysroot ./install notests

.PHONY: default install