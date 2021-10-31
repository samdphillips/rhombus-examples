#lang racket/base

;; My completely unofficial rules for renaming Racket names to Rhombus

(provide rhombus-rename)

(define ((rhombus-rename [override null]) name)
  (define (rename name)
    (cond
      [(assoc name override)
       => (lambda (p) (cdr p))]
      [(regexp-match #px"^(.*)\\?$" name)
       => (lambda (m) (rename (string-append "is_" (cadr m))))]
      [(regexp-match #px"^(.*)!$" name)
       => (lambda (m) (rename (cadr m)))]
      [(regexp-match #px"->" name)
       (rename (regexp-replace* #px"->" name "_to_"))]
      [(regexp-match #px"/" name)
       (rename (regexp-replace* #px"/" name "_with_"))]
      [(regexp-match #px":" name)
       (rename (regexp-replace* #px":" name "_"))]
      [(regexp-match #px"-" name)
       (rename (regexp-replace* #px"-" name "_"))]
      [else name]))
  (rename name))
