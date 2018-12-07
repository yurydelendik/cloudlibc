WC = $(HOME)/Work/wasmception
CABI = ./contrib/cloudabi

default:
	CC=$(WC)/dist/bin/clang AR=$(WC)/dist/bin/llvm-ar \
	CFLAGS="--target=wasm32-unknown-unknown-wasm --sysroot=$(WC)/sysroot -D__wasm__ -D__CloudABI__ -DCRT1 -I$(CABI)/headers -g -O2" \
	./build notests

install: default
	PREFIX=`pwd`/_sysroot ./install notests

clean:
	rm -rf _sysroot _obj

.PHONY: default install clean