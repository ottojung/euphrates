
%run guile

%use (assert=HS) "./euphrates/assert-equal-hs.scm"
%use (list-permutations) "./euphrates/list-permutations.scm"

(let () ;; list-permutations
  (assert=HS '((1 2 3 4) (2 1 3 4) (1 3 2 4) (3 1 2 4) (2 3 1 4) (3 2 1 4) (1 2 4 3) (2 1 4 3) (1 4 2 3) (4 1 2 3) (2 4 1 3) (4 2 1 3) (1 3 4 2) (3 1 4 2) (1 4 3 2) (4 1 3 2) (3 4 1 2) (4 3 1 2) (2 3 4 1) (3 2 4 1) (2 4 3 1) (4 2 3 1) (3 4 2 1) (4 3 2 1))
             (list-permutations (list 1 2 3 4))))
