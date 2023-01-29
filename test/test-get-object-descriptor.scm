
(cond-expand
 (guile
  (define-module (test-get-object-descriptor)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates get-object-descriptor) :select (get-object-descriptor))
    :use-module ((euphrates hashmap) :select (make-hashmap))
    :use-module ((euphrates hashset) :select (list->hashset)))))


(define (test1 name obj)
  (assert=
   name (cdr (assoc 'name (get-object-descriptor obj)))))

(use-modules (ice-9 pretty-print))

(test1 'true #t)
(test1 'string "hello")
(test1 'hash-table (make-hashmap))
(test1 'hashset (list->hashset '()))
