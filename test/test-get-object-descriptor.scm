
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (get-object-descriptor) "./euphrates/get-object-descriptor.scm"
%use (make-hashmap) "./euphrates/hashmap.scm"
%use (list->hashset) "./euphrates/hashset.scm"

(define (test1 name obj)
  (assert=
   name (cdr (assoc 'name (get-object-descriptor obj)))))

(use-modules (ice-9 pretty-print))

(test1 'true #t)
(test1 'string "hello")
(test1 'hash-table (make-hashmap))
(test1 'hashset (list->hashset '()))
