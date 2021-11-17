#lang rhombus

export:
  tcp
  Tcp
  tcp_dot_provider

import:
  rhombus/macro: no_prefix
  racket/tcp:
    rename:
      #{tcp-listen} ~to listen
      #{tcp-accept} ~to accept
      #{tcp-close} ~to close

annotation.macro 'Tcp:
  annotation_ct.pack_predicate('(tcp.#{tcp-listener?}),
                               '(($(dot_ct.provider_key), tcp_dot_provider)))
dot.macro '(tcp_dot_provider $left $dot $right):
  match right
  // One argument functions
  | 'close:  '(fun(): (tcp.close($left)))
  | 'accept: '(fun(): (tcp.accept($left)))