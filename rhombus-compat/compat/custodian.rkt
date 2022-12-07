#lang rhombus

import:
  rhombus/meta open

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
  all_from(.custodian)
  Custodian
  custodian_dot_provider

annot.macro 'Custodian':
  values(annot_meta.pack_predicate('r.#{custodian?}',
                                   '(($(statinfo_meta.dot_provider_key),
                                      custodian_dot_provider))'),
         '')

dot.macro 'custodian_dot_provider $left $dot $right':
  match right
  | 'limit_memory': 'fun(arg): custodian.limit_memory($left, arg)'
  | 'shutdown': 'fun(): custodian.shutdown($left)'

