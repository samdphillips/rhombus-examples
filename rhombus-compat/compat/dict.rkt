#lang rhombus

import:
  rhombus/macro open
  racket/dict:
    rename:
      #{dict-ref} as ref
      #{dict-set} as set
      #{dict?}    as is_dict

export:
  all_in(dict)
  dict_dot_provider
  Dict

annotation.macro 'Dict':
  annotation_ct.pack_predicate('dict.#{is_dict}',
                               '($(dot_ct.provider_key), dict_dot_provider)')
dot.macro 'dict_dot_provider $left $dot $right':
  match right
  // One argument functions
  | 'ref':  'fun(arg): dict.ref($left, arg)'
  | 'set':  'fun(key, val): dict.set($left, key, val)'
