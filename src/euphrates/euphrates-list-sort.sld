
(define-library
    (euphrates euphrates-list-sort)
  (export euphrates:list-sort)
  (import
   (only (scheme base)
         begin
         cond-expand
         define))
  (cond-expand
   (guile
    (import (only (guile) sort-list))
    (begin (define euphrates:list-sort sort-list)))
   (srfi-32
    (import (only (srfi srfi-32) list-sort))
    (begin (define euphrates:list-sort list-sort)))
   (srfi-132
    (import (only (srfi srfi-132) list-sort))
    (begin (define euphrates:list-sort list-sort)))))
