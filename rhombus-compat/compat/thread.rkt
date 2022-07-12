#lang rhombus

import:
  rhombus/meta open
  racket/base as r

export:
  Thread
  thread_dot_provider
  thread

annotation.macro 'Thread':
  values(annotation_meta.pack_predicate('r.#{thread?}',
                                        '(($(statinfo_meta.dot_provider_key), thread_dot_provider))'),
         '')

dot.macro 'thread_dot_provider $left $dot $right':
  match right
  // One argument functions
  | 'kill': 'r.#{kill-thread}($left)'

expr.rule 'thread: $body':
  'r.thread(fun (): $body)'

