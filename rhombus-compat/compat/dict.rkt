#lang rhombus

import:
  rhombus/meta open
  racket/dict:
    rename:
      #{dict-ref} as ref
      #{dict-set} as set
      #{dict?}    as is_dict

export:
  all_from(.dict)
  dict_dot_provider
  Dict

annot.macro 'Dict':
  values(annot_meta.pack_predicate('dict.is_dict',
                                   '(($(statinfo_meta.dot_provider_key),
                                      dict_dot_provider))'),
         '')

dot.macro 'dict_dot_provider $left $dot $right':
  match right
  // One argument functions
  | 'ref':  'fun(arg): dict.ref($left, arg)'
  | 'set':  'fun(key, val): dict.set($left, key, val)'
