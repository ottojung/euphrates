
(cond-expand
 (guile
  (define-module (test-hashset-negative)
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates hashset) :select (hashset-equal? make-hashset)))))

;; hashset-negative

(let ()
  (assert
   ((negate hashset-equal?)
    (make-hashset '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4)))
    (make-hashset '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))))))
