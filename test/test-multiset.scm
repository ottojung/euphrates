
(assert=
 (multiset->list (make-multiset))
 '())

(assert=
 (multiset->list (make-multiset (list 1 2 3 4)))
 (multiset->list (make-multiset (list 1 2 3 4)))
 )

(assert=
 (multiset->list (make-multiset (list 1 2 2 2 3 4)))
 (multiset->list (make-multiset (list 1 2 2 2 3 4)))
 )

(assert
 (not
  (equal?
   (multiset->list (make-multiset (list 1 2 3 4)))
   (multiset->list (make-multiset (list 1 2 2 2 3 4))))))
