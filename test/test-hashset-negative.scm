
%run guile

;; hashset-negative
%use (assert) "./euphrates/assert.scm"
%use (hashset-equal? make-hashset) "./euphrates/hashset.scm"

(let ()
  (assert
   ((negate hashset-equal?)
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))))))
