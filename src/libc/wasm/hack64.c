#include <cloudabi_syscalls.h>

cloudabi_errno_t cloudabi_sys_fd_preadW(cloudabi_fd_t fd,
                                       const cloudabi_iovec_t *iovs,
                                       size_t iovs_len,
                                       cloudabi_filesize_t* offset,
                                       size_t *nread);

cloudabi_errno_t cloudabi_sys_fd_pread(cloudabi_fd_t fd,
                                       const cloudabi_iovec_t *iovs,
                                       size_t iovs_len,
                                       cloudabi_filesize_t offset,
                                       size_t *nread)
{
    return cloudabi_sys_fd_preadW(fd, iovs, iovs_len, &offset, nread);
}

cloudabi_errno_t cloudabi_sys_fd_pwriteW(cloudabi_fd_t fd,
                                        const cloudabi_ciovec_t *iovs,
                                        size_t iovs_len,
                                        cloudabi_filesize_t* offset,
                                        size_t *nwritten);

cloudabi_errno_t cloudabi_sys_fd_pwrite(cloudabi_fd_t fd,
                                        const cloudabi_ciovec_t *iovs,
                                        size_t iovs_len,
                                        cloudabi_filesize_t offset,
                                        size_t *nwritten)
{
    return cloudabi_sys_fd_pwriteW(fd, iovs, iovs_len, &offset, nwritten);
}

cloudabi_errno_t cloudabi_sys_fd_seekW(cloudabi_fd_t fd,
                                      cloudabi_filedelta_t* offset,
                                      cloudabi_whence_t whence,
                                      cloudabi_filesize_t *newoffset);

cloudabi_errno_t cloudabi_sys_fd_seek(cloudabi_fd_t fd,
                                      cloudabi_filedelta_t offset,
                                      cloudabi_whence_t whence,
                                      cloudabi_filesize_t *newoffset)
{
    return cloudabi_sys_fd_seekW(fd, &offset, whence, newoffset);
}

cloudabi_errno_t cloudabi_sys_file_adviseW(cloudabi_fd_t fd,
                                          cloudabi_filesize_t* offset,
                                          cloudabi_filesize_t* len,
                                          cloudabi_advice_t advice);

cloudabi_errno_t cloudabi_sys_file_advise(cloudabi_fd_t fd,
                                          cloudabi_filesize_t offset,
                                          cloudabi_filesize_t len,
                                          cloudabi_advice_t advice)
{
    return cloudabi_sys_file_adviseW(fd, &offset, &len, advice);
}

cloudabi_errno_t cloudabi_sys_file_allocateW(cloudabi_fd_t fd,
                                            cloudabi_filesize_t* offset,
                                            cloudabi_filesize_t* len);

cloudabi_errno_t cloudabi_sys_file_allocate(cloudabi_fd_t fd,
                                            cloudabi_filesize_t offset,
                                            cloudabi_filesize_t len)
{
    return cloudabi_sys_file_allocateW(fd, &offset, &len);
}

cloudabi_errno_t cloudabi_sys_mem_mapW(void *addr, size_t len,
                                      cloudabi_mprot_t prot,
                                      cloudabi_mflags_t flags, cloudabi_fd_t fd,
                                      cloudabi_filesize_t* off, void **mem);

cloudabi_errno_t cloudabi_sys_mem_map(void *addr, size_t len,
                                      cloudabi_mprot_t prot,
                                      cloudabi_mflags_t flags, cloudabi_fd_t fd,
                                      cloudabi_filesize_t off, void **mem)
{
    return cloudabi_sys_mem_mapW(addr, len, prot, flags, fd, &off, mem);
}
