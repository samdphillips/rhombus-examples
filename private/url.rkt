#lang racket/base

(require (for-syntax racket/base
                     "rhombus-names.rkt")
         net/url
         racket/provide)

(provide
 (filtered-out
  (rhombus-rename
   '(["file://->path" . "file_url_to_path"]))
  (all-from-out net/url)))
