#ifndef _GCCT_GINGERBREAD_EXTRA
#define _GCCT_GINGERBREAD_EXTRA

#include <asm/unistd.h>

#ifdef __cplusplus
#include <cerrno>
#else
#include <errno.h>
#endif

#define CHECK_R0_ERRNO { \
    if(r0 < 0) {         \
        errno = -r0;     \
        return -1;       \
    }                    \
    return r0;           \
} \

static __inline__ ssize_t pread64(int fd, void* buf, size_t count, int64_t offset) {
    const register long sc_number __asm__("r7") = __NR_pread64;
    register long r0 __asm__("r0") = fd;
    const register long arg1 __asm__("r1") = (long) buf;
    const register long arg2 __asm__("r2") = count;
    const register unsigned long arg3_pair0 __asm__("r4") = offset & 0xFFFFFFFF;
    const register unsigned long arg3_pair1 __asm__("r5") = (offset >> 32) & 0xFFFFFFFF;

    __asm__ volatile (
        "svc #0"
        : "+r"(r0)
        : "r"(arg1), "r"(arg2), "r"(arg3_pair0), "r"(arg3_pair1), "r"(sc_number)
        : "memory"
    );
    CHECK_R0_ERRNO
}

static __inline__ ssize_t pwrite64(int fd, const void *buf, size_t nbytes, int64_t offset ) {
    const register long sc_number __asm__("r7") = __NR_pwrite64;
    register long r0 __asm__("r0") = fd;
    const register long arg1 __asm__("r1") = (long) buf;
    const register long arg2 __asm__("r2") = nbytes;
    const register unsigned long arg3_pair0 __asm__("r4") = offset & 0xFFFFFFFF;
    const register unsigned long arg3_pair1 __asm__("r5") = (offset >> 32) & 0xFFFFFFFF;

    __asm__ volatile (
        "svc #0"
        : "+r"(r0)
        : "r"(arg1), "r"(arg2), "r"(arg3_pair0), "r"(arg3_pair1), "r"(sc_number)
        : "memory"
    );
    CHECK_R0_ERRNO
}


static __inline__ int truncate64(const char* path, int64_t length ) {
    const register long sc_number __asm__("r7") = __NR_truncate64;
    register long r0 __asm__("r0") = (long) path;
    const register unsigned long arg1_pair0 __asm__("r2") = length & 0xFFFFFFFF;
    const register unsigned long arg1_pair1 __asm__("r3") = (length >> 32) & 0xFFFFFFFF;
    __asm__ volatile (
        "svc #0"
        : "+r"(r0)
        : "r"(arg1_pair0), "r"(arg1_pair1), "r"(sc_number)
        : "memory"
    );
    CHECK_R0_ERRNO
}

static __inline__ int ftruncate64(int fd, int64_t length ) {
    const register long sc_number __asm__("r7") = __NR_ftruncate64;
    register long r0 __asm__("r0") = (long) fd;
    const register unsigned long arg1_pair0 __asm__("r2") = length & 0xFFFFFFFF;
    const register unsigned long arg1_pair1 __asm__("r3") = (length >> 32) & 0xFFFFFFFF;
    __asm__ volatile (
        "svc #0"
        : "+r"(r0)
        : "r"(arg1_pair0), "r"(arg1_pair1), "r"(sc_number)
        : "memory"
    );

    CHECK_R0_ERRNO
}

#undef CHECK_R0_ERRNO

#endif
