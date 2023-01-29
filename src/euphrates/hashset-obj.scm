
(cond-expand
 (guile
  (define-module (euphrates hashset-obj)
    :export (hashset-constructor hashset-predicate hashset-value)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 hashset
  (hashset-constructor value) hashset-predicate
  (value hashset-value))
