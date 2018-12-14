LLVM_BIN = $(HOME)/Work/llvmwasm/llvm-build
CABI = ./contrib/cloudabi

default:
	CC=$(LLVM_BIN)/bin/clang AR=$(LLVM_BIN)/bin/llvm-ar \
	CFLAGS="--target=wasm32-unknown-unknown-wasm -D__wasm__ -D__CloudABI__ -DCRT1 -DNOVDSO -I$(CABI)/headers -g -O2" \
	./build notests

install: default
	PREFIX=`pwd`/_sysroot ./install notests
	install -m 444 contrib/libc.imports "`pwd`/_sysroot/lib/"

contrib/libc.imports:
	grep "syscall " contrib/cloudabi/cloudabi.txt | awk '{print "cloudabi_sys_" $$2}' > contrib/libc.imports
	echo "__thread_control_block" >> contrib/libc.imports

clean:
	rm -rf _sysroot _obj

examples/t.wasm: examples/t.c
	$(LLVM_BIN)/bin/clang --target=wasm32-unknown-unknown-wasm --sysroot=_sysroot \
	examples/t.c -o examples/t.wasm -g -O2

.PHONY: default install clean
