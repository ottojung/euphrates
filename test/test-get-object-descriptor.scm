
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (get-object-descriptor) "./src/get-object-descriptor.scm"
%use (hashmap) "./src/hashmap.scm"
%use (hashset) "./src/hashset-obj.scm"
%use (list->hashset) "./src/ihashset.scm"

(define (test1 name obj)
  (assert=
   name (cdr (assoc 'name (get-object-descriptor obj)))))

(use-modules (ice-9 pretty-print))

(test1 'true #t)
(test1 'string "hello")
(test1 'hash-table (hashmap))
(test1 'hashset (list->hashset '()))
