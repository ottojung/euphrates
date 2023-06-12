
(define-library
  (euphrates hashmap-obj)
  (export hashmap-constructor hashmap-predicate)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import
             (only (guile)
                   include-from-path
                   make-hash-table
                   hash-table?))
           (begin
             (include-from-path "euphrates/hashmap-obj.scm")))
    (else (include "hashmap-obj.scm"))))
