
(define-library
  (euphrates list-partition)
  (export list-partition)
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
             (include-from-path
               "euphrates/list-partition.scm")))
    (else (include "list-partition.scm"))))
