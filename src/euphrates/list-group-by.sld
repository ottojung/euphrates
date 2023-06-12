
(define-library
  (euphrates list-group-by)
  (export list-group-by)
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (scheme base)
          begin
          cons
          define
          for-each
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-group-by.scm")))
    (else (include "list-group-by.scm"))))
