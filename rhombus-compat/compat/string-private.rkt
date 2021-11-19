#lang racket/base
(require (for-syntax racket/base syntax/parse)
         rhombus/private/binding
         rhombus/private/static-info
         rhombus/private/map-ref-set-key
         rhombus/private/call-result-key
         rhombus/private/composite
         (submod rhombus/private/annotation for-class))

;;;
;;; 4.4. String
;;;

; Section "4.4. Strings" in the references:
; https://docs.racket-lang.org/reference/strings.html

;;; Goals
; - use short names
; - the annotation for strings are String
; - s.name becomes  (string-name s), when s is declared to be a String
; - string reference, s[ ] can be used for indexing as well as substrings

;;; Reference
; Constructor: String

; s[i]      = stringref(s,i)
; s[i--j]   = substring(s,i,j)
; s[i--end] = substring(s,i)
; s[ --j]   = substring(0,j)

; Note: The operator -- is defined in "range.rkt"
;       and produces a list of two elements:
;       the indices i and j.
;       False indicates beginning or end.


;;;
;;; Constructor
;;;
(define String string)
(provide String
         (for-space rhombus/binding     String)
         (for-space rhombus/annotation  String)
         (for-space rhombus/static-info String))

;;;
;;; String Reference / String Slppicing
;;;

; We need a slightly extended version of string-ref in order
; to support ranges in the s[ ] notation.

(require (only-in "string-common.rkt" string-ref*))

#;(define (string-ref* s i)
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
      [else
       (raise-argument-error 'string-ref* "expected a range")]))

;;;
;;; String Annotation
;;; 

;; Static Info

(define-for-syntax string-static-info
  #'((#%map-ref    string-ref*)
     ; (#%map-set!   string-set!)
     (#%map-append string-append)))
; Note: These strings aren't mutable, so set! is commented out.

(define-annotation-syntax String
  (annotation-constructor #'String #'string? string-static-info
                          1
                          (lambda (arg-id predicate-stxs)
                            #`(for/and ([e (in-string #,arg-id)])
                                (#,(car predicate-stxs) e)))
                          (lambda (static-infoss)
                            #`((#%ref-result #,(car static-infoss))))))

(define-static-info-syntax String
  (#%call-result ((#%map-ref  string-ref*)
                  ; (#%map-set! string-set!)
                  (#%map-append string-append))))

;;;
;;; Binding Syntax
;;;

; The bindings syntax determines what happens in the case where String
; appears in a binding position. A formal argument is one such place:
;    def middle(String(a,_,b)): [a,b]
;    middle("xyz")===[#{#\x},#{#\z}]
; For now the binding syntax supports strings of a fixed length only.
; TODO: What should the syntax be for a "rest argument".

(define-binding-syntax String
  (binding-prefix-operator
   #'String
   '((default . stronger))
   'macro
   (lambda (stx)
     (syntax-parse stx
       [(form-id ((~and tag (~datum parens)) arg ...) . tail)
        (define args (syntax->list #'(arg ...)))
        (define len (length args))
        (define pred #`(lambda (v)
                         (and (string? v)
                              (= (string-length v) #,len))))
        ((make-composite-binding-transformer pred
                                             (for/list ([arg (in-list args)]
                                                        [i   (in-naturals)])
                                               #`(lambda (v) (string-ref v #,i)))
                                             (for/list ([arg (in-list args)])
                                               #'())
                                             #:ref-result-info? #t)
         stx)]))))
