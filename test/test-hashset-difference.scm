
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert) assert))
   (import
     (only (euphrates hashset)
           hashset-difference
           hashset-equal?
           make-hashset))
   (import
     (only (scheme base) begin cond-expand let quote))))


;; hashset-difference

(let ()
  (assert
   (hashset-equal?
    (make-hashset '(1 2 3))
    (hashset-difference
     (make-hashset '(1 2 3 4 5))
     (make-hashset '(4 5 7 8))))))
