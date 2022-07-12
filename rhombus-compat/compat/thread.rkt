#lang rhombus

import:
  rhombus/macro open
  racket/base as r

export:
  Thread
  thread_dot_provider
  thread

annotation.macro 'Thread':
  values(annotation_ct.pack_predicate('r.#{thread?}',
                                      '(($(dot_ct.provider_key), thread_dot_provider))'),
         '')

dot.macro 'thread_dot_provider $left $dot $right':
  match right
  // One argument functions
  | 'kill': 'fun (): r.#{kill-thread}($left)'
  | 'wait': 'fun (): r.#{thread-wait}($left)'

expr.rule 'thread: $body':
  'r.thread(fun (): $body)'

