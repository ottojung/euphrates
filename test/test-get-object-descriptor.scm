
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates get-object-descriptor)
           get-object-descriptor))
   (import (only (euphrates hashmap) make-hashmap))
   (import (only (euphrates hashset) list->hashset))
   (import
     (only (scheme base)
           assoc
           begin
           cdr
           cond-expand
           define
           quote
           string))))



(define (test1 name obj)
  (assert=
   name (cdr (assoc 'name (get-object-descriptor obj)))))

(test1 'true #t)
(test1 'string "hello")
(test1 'hash-table (make-hashmap))
(test1 'hashset (list->hashset '()))
