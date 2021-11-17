#lang rhombus

// FIXME: Steal @soegaard's code instead
// https://github.com/soegaard/rhombus-experiments/blob/main/spelling-corrector/string.rkt

import:
  racket/base:
    prefix string
    rename:
      #{string->number} ~to to_number
      #{string-append} ~to sappend


operator(a ++ b):
  string.sappend(a, b)

export: string ++