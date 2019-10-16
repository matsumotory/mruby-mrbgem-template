/* ** mrb_filelistencheck.c - FileListenCheck class
**
** Copyright (c) pyama86 2019
**
** See Copyright Notice in LICENSE
*/

#include "mruby.h"
#include "mruby/data.h"
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#define BUFSIZE 512
#define DONE mrb_gc_arena_restore(mrb, 0);
static const unsigned LINE_LEN = 1500;
static const unsigned MAX_LINES = 65500;
typedef struct {
  int port;
  char *addr;
} mrb_filelistencheck_data;

static const struct mrb_data_type mrb_filelistencheck_data_type = {
    "mrb_filelistencheck_data",
    mrb_free,
};

#define LISTEN(ver)                                                                                \
  static mrb_value mrb_is_listen##ver(mrb_state *mrb, mrb_value self)                              \
  {                                                                                                \
    FILE *tcp;                                                                                     \
    struct in##ver##_addr laddr;                                                                   \
    unsigned short l, r;                                                                           \
    char lip##ver[INET##ver##_ADDRSTRLEN];                                                         \
                                                                                                   \
    unsigned int state;                                                                            \
    mrb_filelistencheck_data *data = DATA_PTR(self);                                               \
                                                                                                   \
    tcp = fopen("/proc/net/tcp", "r");                                                             \
    if (!tcp)                                                                                      \
      mrb_raise(mrb, E_RUNTIME_ERROR, "can't open /proc/net/tcp");                                 \
                                                                                                   \
    char buf[BUFSIZE];                                                                             \
    while (fgets(buf, BUFSIZE, tcp)) {                                                             \
      sscanf(buf, "%*u: %X:%hX %*X:%*hX %hhX %*X:%*X %*X:%*X %*X", &(laddr.s##ver##_addr), &l,     \
             &state);                                                                              \
                                                                                                   \
      inet_ntop(AF_INET, (struct in_addr *)&(laddr.s##ver##_addr), lip##ver, sizeof(lip##ver));    \
                                                                                                   \
      if (data->port == l && strcmp(lip##ver, data->addr) == 0 && state == TCP_LISTEN)             \
        return mrb_true_value();                                                                   \
    }                                                                                              \
    return mrb_false_value();                                                                      \
  }

LISTEN()
LISTEN(6)

static mrb_value mrb_filelistencheck_init(mrb_state *mrb, mrb_value self)
{
  mrb_filelistencheck_data *data;

  data = (mrb_filelistencheck_data *)DATA_PTR(self);
  if (data) {
    mrb_free(mrb, data);
  }
  DATA_TYPE(self) = &mrb_filelistencheck_data_type;
  DATA_PTR(self) = NULL;
  data = (mrb_filelistencheck_data *)mrb_malloc(mrb, sizeof(mrb_filelistencheck_data));
  mrb_get_args(mrb, "zi", &data->addr, &data->port);
  DATA_PTR(self) = data;

  return self;
}

static mrb_value mrb_filelistencheck_hello(mrb_state *mrb, mrb_value self)
{
  mrb_filelistencheck_data *data = DATA_PTR(self);

  return mrb_fixnum_value(data->port);
}

void mrb_mruby_file_listen_checker_gem_init(mrb_state *mrb)
{
  struct RClass *filelistencheck;
  filelistencheck = mrb_define_class(mrb, "FileListenCheck", mrb->object_class);
  mrb_define_method(mrb, filelistencheck, "initialize", mrb_filelistencheck_init, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, filelistencheck, "listen?", mrb_is_listen, MRB_ARGS_NONE());
  mrb_define_method(mrb, filelistencheck, "listen6?", mrb_is_listen6, MRB_ARGS_NONE());
  mrb_define_method(mrb, filelistencheck, "hello", mrb_filelistencheck_hello, MRB_ARGS_NONE());
  DONE;
}

void mrb_mruby_file_listen_checker_gem_final(mrb_state *mrb)
{
}
