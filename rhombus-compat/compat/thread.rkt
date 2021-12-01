#lang rhombus

import:
  rhombus/macro open
  racket/base as r

export:
  Thread
  thread_dot_provider
  thread

annotation.macro 'Thread:
  annotation_ct.pack_predicate('(r.#{thread?}),
                               '(($(dot_ct.provider_key), thread_dot_provider)))
dot.macro '(thread_dot_provider $left $dot $right):
  match right
  // One argument functions
  | 'kill: '(r.#{kill-thread}($left))

expr.rule '(thread: $body ... ; ...):
  '(r.thread(fun (): $body ... ; ...))
