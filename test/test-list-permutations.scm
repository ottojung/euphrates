
(cond-expand
 (guile
  (define-module (test-list-permutations)
    :use-module ((euphrates assert-equal-hs) :select (assert=HS))
    :use-module ((euphrates list-permutations) :select (list-permutations)))))


(let () ;; list-permutations
  (assert=HS '((1 2 3 4) (2 1 3 4) (1 3 2 4) (3 1 2 4) (2 3 1 4) (3 2 1 4) (1 2 4 3) (2 1 4 3) (1 4 2 3) (4 1 2 3) (2 4 1 3) (4 2 1 3) (1 3 4 2) (3 1 4 2) (1 4 3 2) (4 1 3 2) (3 4 1 2) (4 3 1 2) (2 3 4 1) (3 2 4 1) (2 4 3 1) (4 2 3 1) (3 4 2 1) (4 3 2 1))
             (list-permutations (list 1 2 3 4))))
