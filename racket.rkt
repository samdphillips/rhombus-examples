#lang racket/base

(require (for-syntax racket/base
                     "rhombus-names.rkt")
         racket/provide)

(provide
 proc_with_handlers

 (filtered-out
  (rhombus-rename)
  (combine-out
   exn:fail?
   list
   keyword-apply
   make-keyword-procedure)))

;; one case handling exception handling
(define (proc_with_handlers exn? exn-handle body)
  (with-handlers* ([exn? exn-handle])
    (body)))