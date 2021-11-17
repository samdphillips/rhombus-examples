#lang racket/base

(require (for-syntax racket/base
                     syntax/parse)
         rhombus/private/expression
         rhombus/private/parse)

(provide (rename-out (rhombus-parameterize parameterize)))

(begin-for-syntax
  (define-syntax-class :binding
    #:datum-literals (block group)
    #:attributes (name expr)
    (pattern
      (group n ... (block (~and expr (group e ...))))
      #:attr name (syntax/loc #'(n ...) (group n ...)))))

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
         #'(parameterize ([(rhombus-expression bindings.name)
                           (rhombus-expression bindings.expr)] ...)
             (rhombus-body-at tag-body body ...))
         #'tail)]
       [_
        (raise-syntax-error #f
                            "parameterize wrongly"
                            stx)]))))
