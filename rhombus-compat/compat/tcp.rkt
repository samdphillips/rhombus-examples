#lang rhombus

import:
  rhombus/meta open
  racket/tcp:
    rename:
      #{tcp-listen} as listen
      #{tcp-accept} as accept
      #{tcp-close}  as close

export:
  all_from(.tcp)
  Tcp
  tcp_dot_provider

annotation.macro 'Tcp':
  values(annotation_meta.pack_predicate('tcp.#{tcp-listener?}',
                                        '(($(statinfo_meta.dot_provider_key), tcp_dot_provider))'),
         '')

dot.macro 'tcp_dot_provider $left $dot $right':
  match right
  // One argument functions
  | 'close':  'fun(): tcp.close($left)'
  | 'accept': 'fun(): tcp.accept($left)'
