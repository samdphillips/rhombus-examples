#lang rhombus

export: dict
        dict_dot_provider
        Dict

import:
  rhombus/macro: no_prefix
  racket/dict:
    prefix dict
    rename:
      #{dict-ref} ~to ref
      #{dict-set} ~to set
      #{dict?} ~to is_dict

  racket/base:
    prefix r

annotation.macro 'Dict:
  annotation_ct.pack_predicate('(dict.#{is_dict}),
                               '(($(dot_ct.provider_key), dict_dot_provider)))
dot.macro '(dict_dot_provider $left $dot $right):
  match right
  // One argument functions
  | 'ref:  '(fun(arg): (dict.ref($left, arg)))
  | 'set:  '(fun(key,val): (dict.set($left, key, val)))
