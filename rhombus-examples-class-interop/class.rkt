#lang racket/base

(require (for-syntax racket/base
                     syntax/parse)
         rhombus/private/expression
         rhombus/private/parse
         racket/class)

(provide (rename-out [rhombus-new new]))

(begin-for-syntax
  (define-syntax-class :init-field
    #:datum-literals (block group)
    #:attributes (name expr)
    [pattern (group name-kw:keyword (block (~and expr (group e ...))))
             #:attr name
             (datum->syntax
              #'name-kw
              (string->symbol
               (keyword->string
                (syntax->datum #'name-kw)))
              #'name-kw)]))

(define-syntax rhombus-new
  (expression-transformer
   #'rhombus-new
   (lambda (stx)
     (syntax-parse stx
       #:datum-literals (block group parens)
       [(form-id cls-expr ... (parens init-field::init-field ...) . tail)
        (values #'(new (rhombus-expression (group cls-expr ...))
                       [init-field.name (rhombus-expression init-field.expr)]
                       ...)
                #'tail)]))))
