#ifndef LIBLIAN
#define LIBLIAN

#define _GNU_SOURCE
#include <asm/ldt.h>
#include <sys/types.h>
#include <stdio.h>
#include <linux/userfaultfd.h>
#include <pthread.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <poll.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <sys/sem.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <semaphore.h>
#include <poll.h>
#include <sys/xattr.h>
#include <sched.h>

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
#define errExit(X)                                                             \
  printf(COLOR_RED "[-] %s \033[0m\n", (X));                                   \
  exit(0)


void save_status( void );
void get_shell( void );
void bind_cpu( int );

#endif // !LIBLIAN
