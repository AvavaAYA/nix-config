#ifndef LIBLIAN
#define LIBLIAN

#define _GNU_SOURCE
#include <asm/ldt.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/userfaultfd.h>
#include <poll.h>
#include <pthread.h>
#include <sched.h>
#include <semaphore.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/ipc.h>
#include <sys/mman.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/xattr.h>
#include <unistd.h>

#define COLOR_RED "\033[31m"
#define COLOR_GREEN "\033[32m"
#define COLOR_YELLOW "\033[33m"
#define COLOR_BLUE "\033[34m"
#define COLOR_MAGENTA "\033[35m"
#define COLOR_CYAN "\033[36m"
#define COLOR_RESET "\033[0m"
#define log(X)                                                                 \
    printf(COLOR_BLUE "[*] %s --> 0x%lx " COLOR_RESET "\n", (#X), (X))
#define success(X) printf(COLOR_GREEN "[+] %s" COLOR_RESET "\n", (X))
#define info(X) printf(COLOR_MAGENTA "[*] %s" COLOR_RESET "\n", (X))

void errExit(const char *fmt, ...);
void save_status(void);
void get_shell(void);
void bind_cpu(int);

#endif // !LIBLIAN
