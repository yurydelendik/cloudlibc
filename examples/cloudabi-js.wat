(module

(import "cloudabi" "clock_res_get" (func $clock_res_get (param i32 i32) (result i32)))

(import "cloudabi" "clock_time_get" (func $clock_time_getW (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "condvar_signal" (func $condvar_signal (param i32 i32 i32) (result i32)))

(import "cloudabi" "fd_close" (func $fd_close (param i32) (result i32)))

(import "cloudabi" "fd_create1" (func $fd_create1 (param i32 i32) (result i32)))

(import "cloudabi" "fd_create2" (func $fd_create2 (param i32 i32 i32) (result i32)))

(import "cloudabi" "fd_datasync" (func $fd_datasync (param i32) (result i32)))

(import "cloudabi" "fd_dup" (func $fd_dup (param i32 i32) (result i32)))

(import "cloudabi" "fd_pread" (func $fd_preadW (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "fd_pwrite" (func $fd_pwriteW (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "fd_read" (func $fd_read (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "fd_replace" (func $fd_replace (param i32 i32) (result i32)))

(import "cloudabi" "fd_seek" (func $fd_seekW (param i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "fd_stat_get" (func $fd_stat_get (param i32 i32) (result i32)))

(import "cloudabi" "fd_stat_put" (func $fd_stat_put (param i32 i32 i32) (result i32)))

(import "cloudabi" "fd_sync" (func $fd_sync (param i32) (result i32)))

(import "cloudabi" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_advise" (func $file_adviseW (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_allocate" (func $file_allocateW (param i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_create" (func $file_create (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_link" (func $file_link (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_open" (func $file_open (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_readdir" (func $file_readdir (param i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_readlink" (func $file_readlink (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_rename" (func $file_rename (param i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_stat_fget" (func $file_stat_fget (param i32 i32) (result i32)))

(import "cloudabi" "file_stat_fput" (func $file_stat_fput (param i32 i32 i32) (result i32)))

(import "cloudabi" "file_stat_get" (func $file_stat_get (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_stat_put" (func $file_stat_put (param i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_symlink" (func $file_symlink (param i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "file_unlink" (func $file_unlink (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "lock_unlock" (func $lock_unlock (param i32 i32) (result i32)))

(import "cloudabi" "mem_advise" (func $mem_advise (param i32 i32 i32) (result i32)))

(import "cloudabi" "mem_map" (func $mem_mapW (param i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "mem_protect" (func $mem_protect (param i32 i32 i32) (result i32)))

(import "cloudabi" "mem_sync" (func $mem_sync (param i32 i32 i32) (result i32)))

(import "cloudabi" "mem_unmap" (func $mem_unmap (param i32 i32) (result i32)))

(import "cloudabi" "poll" (func $poll (param i32 i32 i32 i32) (result i32)))

(import "cloudabi" "proc_exec" (func $proc_exec (param i32 i32 i32 i32 i32) (result i32)))

(import "cloudabi" "proc_exit" (func $proc_exit (param i32)))

(import "cloudabi" "proc_fork" (func $proc_fork (param i32 i32) (result i32)))

(import "cloudabi" "proc_raise" (func $proc_raise (param i32) (result i32)))

(import "cloudabi" "random_get" (func $random_get (param i32 i32) (result i32)))

(import "cloudabi" "sock_recv" (func $sock_recv (param i32 i32 i32) (result i32)))

(import "cloudabi" "sock_send" (func $sock_send (param i32 i32 i32) (result i32)))

(import "cloudabi" "sock_shutdown" (func $sock_shutdown (param i32 i32) (result i32)))

(import "cloudabi" "thread_create" (func $thread_create (param i32 i32) (result i32)))

(import "cloudabi" "thread_exit" (func $thread_exit (param i32 i32)))

(import "cloudabi" "thread_yield" (func $thread_yield (result i32)))

(func $clock_time_get (param i32 i64 i32) (result i32)
    get_local 0
    get_local 1 i32.wrap/i64 get_local 1 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 2
    call $clock_time_getW
)

(func $fd_pread (param i32 i32 i32 i64 i32) (result i32)
    get_local 0
    get_local 1
    get_local 2
    get_local 3 i32.wrap/i64 get_local 3 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 4
    call $fd_preadW
)

(func $fd_pwrite (param i32 i32 i32 i64 i32) (result i32)
    get_local 0
    get_local 1
    get_local 2
    get_local 3 i32.wrap/i64 get_local 3 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 4
    call $fd_pwriteW
)

(func $fd_seek (param i32 i64 i32 i32) (result i32)
    get_local 0
    get_local 1 i32.wrap/i64 get_local 1 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 2
    get_local 3
    call $fd_seekW
)

(func $file_advise (param i32 i64 i64 i32) (result i32)
    get_local 0
    get_local 1 i32.wrap/i64 get_local 1 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 2 i32.wrap/i64 get_local 2 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 3
    call $file_adviseW
)

(func $file_allocate (param i32 i64 i64) (result i32)
    get_local 0
    get_local 1 i32.wrap/i64 get_local 1 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 2 i32.wrap/i64 get_local 2 i64.const 32 i64.shr_u i32.wrap/i64
    call $file_allocateW
)

(func $mem_map (param i32 i32 i32 i32 i32 i64 i32) (result i32)
    get_local 0
    get_local 1
    get_local 2
    get_local 3
    get_local 4
    get_local 5 i32.wrap/i64 get_local 5 i64.const 32 i64.shr_u i32.wrap/i64
    get_local 6
    call $mem_mapW
)

(export "cloudabi_sys_clock_res_get" (func $clock_res_get))

(export "cloudabi_sys_clock_time_get" (func $clock_time_get))

(export "cloudabi_sys_condvar_signal" (func $condvar_signal))

(export "cloudabi_sys_fd_close" (func $fd_close))

(export "cloudabi_sys_fd_create1" (func $fd_create1))

(export "cloudabi_sys_fd_create2" (func $fd_create2))

(export "cloudabi_sys_fd_datasync" (func $fd_datasync))

(export "cloudabi_sys_fd_dup" (func $fd_dup))

(export "cloudabi_sys_fd_pread" (func $fd_pread))

(export "cloudabi_sys_fd_pwrite" (func $fd_pwrite))

(export "cloudabi_sys_fd_read" (func $fd_read))

(export "cloudabi_sys_fd_replace" (func $fd_replace))

(export "cloudabi_sys_fd_seek" (func $fd_seek))

(export "cloudabi_sys_fd_stat_get" (func $fd_stat_get))

(export "cloudabi_sys_fd_stat_put" (func $fd_stat_put))

(export "cloudabi_sys_fd_sync" (func $fd_sync))

(export "cloudabi_sys_fd_write" (func $fd_write))

(export "cloudabi_sys_file_advise" (func $file_advise))

(export "cloudabi_sys_file_allocate" (func $file_allocate))

(export "cloudabi_sys_file_create" (func $file_create))

(export "cloudabi_sys_file_link" (func $file_link))

(export "cloudabi_sys_file_open" (func $file_open))

(export "cloudabi_sys_file_readdir" (func $file_readdir))

(export "cloudabi_sys_file_readlink" (func $file_readlink))

(export "cloudabi_sys_file_rename" (func $file_rename))

(export "cloudabi_sys_file_stat_fget" (func $file_stat_fget))

(export "cloudabi_sys_file_stat_fput" (func $file_stat_fput))

(export "cloudabi_sys_file_stat_get" (func $file_stat_get))

(export "cloudabi_sys_file_stat_put" (func $file_stat_put))

(export "cloudabi_sys_file_symlink" (func $file_symlink))

(export "cloudabi_sys_file_unlink" (func $file_unlink))

(export "cloudabi_sys_lock_unlock" (func $lock_unlock))

(export "cloudabi_sys_mem_advise" (func $mem_advise))

(export "cloudabi_sys_mem_map" (func $mem_map))

(export "cloudabi_sys_mem_protect" (func $mem_protect))

(export "cloudabi_sys_mem_sync" (func $mem_sync))

(export "cloudabi_sys_mem_unmap" (func $mem_unmap))

(export "cloudabi_sys_poll" (func $poll))

(export "cloudabi_sys_proc_exec" (func $proc_exec))

(export "cloudabi_sys_proc_exit" (func $proc_exit))

(export "cloudabi_sys_proc_fork" (func $proc_fork))

(export "cloudabi_sys_proc_raise" (func $proc_raise))

(export "cloudabi_sys_random_get" (func $random_get))

(export "cloudabi_sys_sock_recv" (func $sock_recv))

(export "cloudabi_sys_sock_send" (func $sock_send))

(export "cloudabi_sys_sock_shutdown" (func $sock_shutdown))

(export "cloudabi_sys_thread_create" (func $thread_create))

(export "cloudabi_sys_thread_exit" (func $thread_exit))

(export "cloudabi_sys_thread_yield" (func $thread_yield))

)