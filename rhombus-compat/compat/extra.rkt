#lang rhombus

export:
  |>
  when
  unless
  thunk
  loop
  letcc

import: racket/base as r
        rhombus/macro open

expr.rule 'letcc $k: $body':
  'r.#{call/cc}(fun($k): $body)'

expr.rule 'loop: $body ...; ...':
  'begin:
      fun lp():
        $body ...; ...
        lp()
      lp()'

expr.rule 'thunk: $body':
  'fun (): $body'


expr.rule 'when $test ... : $body':
  'if $test ...
   | $body
   | r.void()'

expr.rule 'unless $test ... : $body':
  'if $test ...
   | r.void()
   | $body'

operator (a |> b): b(a)
