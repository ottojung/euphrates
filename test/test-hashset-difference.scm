
%run guile

;; hashset-difference
%use (assert) "./src/assert.scm"
%use (hashset-difference hashset-equal? make-hashset) "./src/hashset.scm"

(let ()
  (assert
   (hashset-equal?
    (make-hashset '(1 2 3))
    (hashset-difference
     (make-hashset '(1 2 3 4 5))
     (make-hashset '(4 5 7 8))))))
