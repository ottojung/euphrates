
(cond-expand
 (guile
  (define-module (euphrates multiset-obj)
    :export (multiset-constructor multiset-predicate multiset-value)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 multiset
  (multiset-constructor value) multiset-predicate
  (value multiset-value))
