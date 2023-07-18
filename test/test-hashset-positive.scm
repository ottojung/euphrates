
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates hashset)
           hashset-equal?
           make-hashset))
   (import
     (only (scheme base) begin cond-expand let quote))))


;; hashset-positive

(let ()
  (assert
   (hashset-equal?
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4))))))
