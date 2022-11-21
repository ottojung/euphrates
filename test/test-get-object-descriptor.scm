
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (get-object-descriptor) "./src/get-object-descriptor.scm"
%use (make-hashmap) "./src/hashmap.scm"
%use (list->hashset) "./src/hashset.scm"

(define (test1 name obj)
  (assert=
   name (cdr (assoc 'name (get-object-descriptor obj)))))

(use-modules (ice-9 pretty-print))

(test1 'true #t)
(test1 'string "hello")
(test1 'hash-table (make-hashmap))
(test1 'hashset (list->hashset '()))
