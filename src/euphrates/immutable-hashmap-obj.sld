
(define-library
  (euphrates immutable-hashmap-obj)
  (export
    immutable-hashmap-constructor
    immutable-hashmap-predicate
    immutable-hashmap-value)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/immutable-hashmap-obj.scm")))
    (else (include "immutable-hashmap-obj.scm"))))
