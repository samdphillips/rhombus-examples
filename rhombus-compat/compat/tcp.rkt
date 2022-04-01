#lang rhombus

export:
  tcp
  Tcp
  tcp_dot_provider

import:
  rhombus/macro open
  racket/tcp:
    rename:
      #{tcp-listen} as listen
      #{tcp-accept} as accept
      #{tcp-close}  as close

annotation.macro 'Tcp':
  annotation_ct.pack_predicate('tcp.#{tcp-listener?}',
                               '($(dot_ct.provider_key), tcp_dot_provider)')
dot.macro 'tcp_dot_provider $left $dot $right':
  match right
  // One argument functions
  | 'close':  'fun(): tcp.close($left)'
  | 'accept': 'fun(): tcp.accept($left)'
