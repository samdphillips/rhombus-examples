#lang rhombus

export:
  custodian
  Custodian
  custodian_dot_provider

import:
  rhombus/macro: no_prefix
  racket/control
  
  racket/base:
    prefix custodian
    rename:
      #{current-custodian} ~to current
      #{custodian-shutdown-all} ~to shutdown
      #{make-custodian} ~to make
      #{custodian-limit-memory} ~to limit_memory
      
  racket/base:
    prefix r
    rename:
      #{call/cc} ~to callcc
      #{regexp-match} ~to regexp_match
      #{close-input-port} ~to close_input_port
      #{close-output-port} ~to close_output_port
      #{current-custodian} ~to current_custodian
      #{custodian-shutdown-all} ~to custodian_shutdown_all

annotation.macro 'Custodian:
  annotation_ct.pack_predicate('(r.#{custodian?}),
                               '(($(dot_ct.provider_key), custodian_dot_provider)))
dot.macro '(custodian_dot_provider $left $dot $right):
  match right
  // One argument functions
  | 'limit_memory:  '(fun(arg): (custodian.limit_memory($left, arg)))
  | 'shutdown: '(fun(): (custodian.shutdown($left)))
