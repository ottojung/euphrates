
(cond-expand
  (guile)
  ((not guile)
   (import
     (only (euphrates assert-equal-hs) assert=HS))
   (import
     (only (euphrates list-permutations)
           list-permutations))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           list
           quote))))



(let () ;; list-permutations
  (assert=HS '((1 2 3 4) (2 1 3 4) (1 3 2 4) (3 1 2 4) (2 3 1 4) (3 2 1 4) (1 2 4 3) (2 1 4 3) (1 4 2 3) (4 1 2 3) (2 4 1 3) (4 2 1 3) (1 3 4 2) (3 1 4 2) (1 4 3 2) (4 1 3 2) (3 4 1 2) (4 3 1 2) (2 3 4 1) (3 2 4 1) (2 4 3 1) (4 2 3 1) (3 4 2 1) (4 3 2 1))
             (list-permutations (list 1 2 3 4))))
