#lang rhombus

export:
  |>
  when
  thunk
  loop
  letcc

import: racket/base: prefix r
        rhombus/macro: no_prefix

expr.rule '(letcc $k: $body ...; ...):
  '(r.#{call/cc}(fun($k): $body ...; ...))

expr.rule '(loop: $body ...; ...):
  '(begin:
      fun lp():
        $body ...; ...
        lp()
      lp())

expr.rule '(thunk: $body ... ; ...):
  '(fun (): $body ... ; ...)


expr.rule '(when $e ... : $body ... ; ...):
  '(if $e ...
    | $body ... ; ...
    | r.void())

operator (a |> b): b(a)
