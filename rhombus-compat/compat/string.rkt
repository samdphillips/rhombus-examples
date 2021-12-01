#lang rhombus

// FIXME: Steal @soegaard's code instead
// https://github.com/soegaard/rhombus-experiments/blob/main/spelling-corrector/string.rkt

import:
  racket/base as string:
    rename:
      #{string->number} as to_number
      #{string-append}  as sappend


operator(a ++ b):
  string.sappend(a, b)

export: string ++