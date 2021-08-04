#lang racket/base

(provide
 list
 proc_with_handlers
 (rename-out
  [exn:fail? is_exn_fail]
  [keyword-apply keyword_apply]
  [make-keyword-procedure make_kw_proc]))

;; one case exception handling
(define (proc_with_handlers exn? exn-handle body)
  (with-handlers* ([exn? exn-handle])
    (body)))
