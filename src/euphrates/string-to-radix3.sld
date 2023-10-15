
(define-library
  (euphrates string-to-radix3)
  (export string->radix3)
  (import
    (only (euphrates hashmap)
          alist->hashmap
          hashmap-ref))
  (import
    (only (euphrates radix3-parse-basevector)
          radix3:parse-basevector))
  (import
    (only (euphrates radix3) radix3-constructor))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates string-split-3) string-split-3))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          -
          begin
          cons
          define
          define-values
          if
          lambda
          list
          map
          quote
          string
          string->list
          string-length
          substring
          unless
          vector->list
          vector-length
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import
             (only (srfi srfi-13) string-null? string-suffix?)))
    (else (import
            (only (srfi 13) string-null? string-suffix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-radix3.scm")))
    (else (include "string-to-radix3.scm"))))
