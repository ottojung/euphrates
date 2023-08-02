
(define-library
  (euphrates list-group-by)
  (export list-group-by)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (scheme base)
          begin
          cons
          define
          for-each
          lambda
          list
          map
          null?
          quote
          reverse
          set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-group-by.scm")))
    (else (include "list-group-by.scm"))))
