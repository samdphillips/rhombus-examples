#lang racket/base

(require racket/class)

(provide Add
         Sub)

(define Op
  (class object%
    (init-field left right)
    (super-new)

    (abstract eval)))

(define (apply-op f)
  (class Op
    (super-new)
    (inherit-field left right)
    (define/override (eval) (f left right))))

(define Add (apply-op +))
(define Sub (apply-op -))

