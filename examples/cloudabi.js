window.createCloudabi = async function () {
    let exitCode = null;
    let memory;
    const memMap = [];

    const not_implemented = () => { debugger; };
    const cloudabi = {
        clock_res_get: not_implemented,
        clock_time_get: not_implemented,
        condvar_signal: not_implemented,
        fd_close(fd) {
            return 0;
        },
        fd_create1: not_implemented,
        fd_create2: not_implemented,
        fd_datasync: not_implemented,
        fd_dup: not_implemented,
        fd_pread: not_implemented,
        fd_pwrite(fd, iovs, iovs_len, offsetLow, offsetHigh, nwrittenPtr) {
            const dv = new DataView(memory.buffer, 0, memory.buffer.byteLength);
            let nwritten = 0;
            let decoder = new TextDecoder('utf-8');
            for (let p = iovs, i = 0; i < iovs_len; i++, p += 8) {
                const buf = dv.getUint32(p, true);
                const buf_len = dv.getUint32(p + 4, true);
                console.log('pwrite', decoder.decode(new Uint8Array(memory.buffer, buf, buf_len)));
                nwritten += buf_len;
            }
            dv.setUint32(nwrittenPtr, nwritten, true);
            return 0;
        },
        fd_read: not_implemented,
        fd_replace: not_implemented,
        fd_seek(fd, offsetLow, offsetHigh, whence, newoffsetPtr) {
            const dv = new DataView(memory.buffer, 0, memory.buffer.byteLength);
            switch (whence) {
                case 1: // #define CLOUDABI_WHENCE_CUR 1
                case 3: // CLOUDABI_WHENCE_SET 3
                    dv.setUint32(newoffsetPtr, offsetLow, true);
                    dv.setUint32(newoffsetPtr + 4, offsetHigh, true);
                    break;
                case 2:// #define CLOUDABI_WHENCE_END 2
                    if (offsetLow != 0 || offsetHigh != 0) {
                        return 70; // CLOUDABI_ESPIPE
                    }
                    dv.setUint32(newoffsetPtr,0, true);
                    dv.setUint32(newoffsetPtr + 4,0, true);
                    break;
                default: return 70; // CLOUDABI_ESPIPE
            }
            return 0;
        },
        fd_stat_get: not_implemented,
        fd_stat_put: not_implemented,
        fd_sync: not_implemented,
        fd_write: not_implemented,
        file_advise: not_implemented,
        file_allocate: not_implemented,
        file_create: not_implemented,
        file_link: not_implemented,
        file_open: not_implemented,
        file_readdir: not_implemented,
        file_readlink: not_implemented,
        file_rename: not_implemented,
        file_stat_fget: not_implemented,
        file_stat_fput: not_implemented,
        file_stat_get: not_implemented,
        file_stat_put: not_implemented,
        file_symlink: not_implemented,
        file_unlink: not_implemented,
        lock_unlock: not_implemented,
        mem_advise: not_implemented,
        mem_map(addr, len, prot, flags, fd, offLow, offHigh, memPtr) {
            if (fd != -1) {
                return 2; // EACCES
            }
            if (addr & 0xFFFF || len & 0xFFFF) {
                return 28; // CLOUDABI_EINVAL
            }
            if (addr) {
                // TODO check if mmaped
                const dv = new DataView(memory.buffer, memPtr, 4);
                dv.setUint32(0, addr, true);
                return 0;
            }
            let p;
            let delta = len >>> 16;
            if (memMap.length == 0) {
                // Simple case
                p = memory.grow(delta);
                if (p >> 0 == -1) {
                    return 48; // CLOUDABI_ENOMEM
                }
                memMap.push(p + delta, p + delta);
            } else {
                let found = false;
                for (let i = 0; i < memMap.length; i += 2) {
                    if (memMap[i] + delta <= memMap[i + 1]) {
                        p = memMap[i];
                        if (memMap[i] + delta < memMap[i + 1] || i + 2 >= memMap.length) {
                            memMap[i] += delta;
                        } else {
                            memMap.splice(i, 2);
                        }
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    const te = memMap.pop();
                    const ts = memMap.pop();
                    const need = delta - (te - ts);
                    const deltap = memory.grow(need);
                    if (deltap >> 0 == -1) {
                        return 48; // CLOUDABI_ENOMEM
                    }
                    // assert  (deltap == te)
                    memMap.push(te + need, te + need);
                    p = ts;
                }
            }
            console.log('mmap', p, delta, memMap);
            const dv = new DataView(memory.buffer, memPtr, 4);
            dv.setUint32(0, p * 65536, true);
            return 0;
        },
        mem_protect: not_implemented,
        mem_sync: not_implemented,
        mem_unmap(addr, len) {
            if ((addr & 0xFFFF) || (len & 0xFFFF)) {
                return 28; // CLOUDABI_EINVAL
            }
            const s = addr >>> 16, e = (addr + len) >>> 16;
            for (let i = 0; i < memMap.length; i += 2) {
                if (s < memMap[i]) {
                    // assert e <= memMap[i]
                    if (e == memMap[i]) {
                        memMap[i] = s;
                    } else {
                        memMap.splice(i, 0, s, e);
                    }
                    if (i > 0 && memMap[i - 1] == s) {
                        memMap.splice(i - 1, 2);
                    }
                    break;
                }
            }
            console.log('munmap', s, e, memMap);
            return 0;
        },
        poll: not_implemented,
        proc_exec: not_implemented,
        proc_exit(exitcode) {
            exitCode = exitcode;
        },
        proc_fork: not_implemented,
        proc_raise: not_implemented,
        random_get: not_implemented,
        sock_recv: not_implemented,
        sock_send: not_implemented,
        sock_shutdown: not_implemented,
        thread_create: not_implemented,
        thread_exit: not_implemented,
        thread_yield: not_implemented,
    }
    const { instance } = await WebAssembly.instantiateStreaming(fetch("cloudabi-js.wasm"), { cloudabi, });
    return {
        set memory(value) { memory = value; },
        exports: instance.exports,
        get exitCode() { return exitCode; } 
    };
};