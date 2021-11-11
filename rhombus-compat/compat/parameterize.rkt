#lang racket/base

(require (for-syntax racket/base
                     syntax/parse)
         rhombus/private/expression
         rhombus/private/parse)

(provide (rename-out (rhombus-parameterize parameterize)))

(begin-for-syntax
  (define-syntax-class :binding
    #:datum-literals (block group)
    (pattern (group name:identifier (block (~and expr (group e ...)))))))

(define-syntax rhombus-parameterize
  (expression-transformer
   #'rhombus-parameterize
   (lambda (stx)
     (syntax-parse stx
       #:datum-literals (block group parens)
       [(form-id (parens bindings::binding ...)
                 ((~and tag-body block) body ...)
                 . tail)
        (values
         #'(parameterize ([bindings.name
                           (rhombus-expression bindings.expr)] ...)
             (rhombus-body-at tag-body body ...))
         #'tail)]
       [_
        (raise-syntax-error #f
                            "parameterize wrongly"
                            stx)]))))
