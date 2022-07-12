#lang rhombus

import:
  rhombus/macro open

  racket/base as r
  racket/base as custodian:
    rename:
      #{current-custodian}      as current
      #{custodian-shutdown-all} as shutdown
      #{make-custodian}         as make
      #{custodian-limit-memory} as limit_memory
    only:
      current
      shutdown
      make
      limit_memory

export:
  all_in(custodian)
  Custodian
  custodian_dot_provider

annotation.macro 'Custodian':
  values(annotation_ct.pack_predicate('r.#{custodian?}',
                                      '(($(dot_ct.provider_key), custodian_dot_provider))'),
         '')

dot.macro 'custodian_dot_provider $left $dot $right':
  match right
  | 'limit_memory': 'fun(arg): custodian.limit_memory($left, arg)'
  | 'shutdown': 'fun(): custodian.shutdown($left)'

