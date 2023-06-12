


(define (test1 name obj)
  (assert=
   name (cdr (assoc 'name (get-object-descriptor obj)))))

(test1 'true #t)
(test1 'string "hello")
(test1 'hash-table (make-hashmap))
(test1 'hashset (list->hashset '()))
