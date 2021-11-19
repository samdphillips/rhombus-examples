#lang racket/base
(require "range-private.rkt")
(provide string-ref*)

; Functions defined here are exported to the Rhombus layer.

(define (string-ref* s i)
  (cond
    [(integer? i)
     (string-ref s i)]
    [(and (list? i) (= (length i) 2))
     (define from (list-ref i 0))
     (define to   (list-ref i 1))
     (cond
       [(and from to) (substring s from to)]
       [from          (substring s from)]
       [to            (substring s 0 to)])]
    [(range? i)
     (string-ref* s (range-spec i))]
    [else
     (raise-argument-error 'string-ref* "expected a range")]))