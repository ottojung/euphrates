
(cond-expand
 (guile
  (define-module (euphrates hashmap-obj)
    :export (hashmap-constructor hashmap-predicate))))

(cond-expand
 (guile
  (define hashmap-constructor make-hash-table)
  (define hashmap-predicate hash-table?))
 (racket
  (define hashmap-constructor make-hash)
  (define hashmap-predicate hash?)))
