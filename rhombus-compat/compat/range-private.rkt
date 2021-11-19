#lang racket/base
(provide range-start
         range-end
         make-range
         (struct-out range))

; (provide (for-space rhombus make-range))

;;;
;;; Ranges
;;;

; For now a spec is simply a (list start end),
; where #f means 0 or infinity respectively.

; For arrays generalized ranges as in srfi 179 it is possible
; for the spec to be a list of intervals.

(struct range (single? spec))

(define (range-start r)
  (car (range-spec r)))

(define (range-end r)
  (cadr (range-spec r)))

(define (make-range a b)
  (range #t (list a b)))



         
  

