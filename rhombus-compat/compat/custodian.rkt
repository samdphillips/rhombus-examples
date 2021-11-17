#lang rhombus

import:
  rhombus/macro: no_prefix

  racket/base:
    prefix custodian
    rename:
      #{current-custodian} ~to current
      #{custodian-shutdown-all} ~to shutdown
      #{make-custodian} ~to make
      #{custodian-limit-memory} ~to limit_memory
    only:
      current
      shutdown
      make
      limit_memory

export:
  all_in(custodian)
  Custodian
  custodian_dot_provider

annotation.macro 'Custodian:
  annotation_ct.pack_predicate('(r.#{custodian?}),
                               '(($(dot_ct.provider_key), custodian_dot_provider)))

dot.macro '(custodian_dot_provider $left $dot $right):
  match right
  // One argument functions
  | 'limit_memory:  '(fun(arg): (custodian.limit_memory($left, arg)))
  | 'shutdown: '(fun(): (custodian.shutdown($left)))
