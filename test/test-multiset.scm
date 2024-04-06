
(assert=
 (multiset->list (make-multiset))
 '())

(assert=
 (multiset->list (list->multiset (list 1 2 3 4)))
 (multiset->list (list->multiset (list 1 2 3 4)))
 )

(assert=
 (multiset->list (list->multiset (list 1 2 2 2 3 4)))
 (multiset->list (list->multiset (list 1 2 2 2 3 4)))
 )

(assert
 (not
  (equal?
   (multiset->list (list->multiset (list 1 2 3 4)))
   (multiset->list (list->multiset (list 1 2 2 2 3 4))))))

(assert
 (multiset-has?
  (multiset->list (list->multiset (list 1 2 3 4)))
  2))
