
%run guile

;; list-combinations

%use (assert=HS) "./euphrates/assert-equal-hs.scm"
%use (list-combinations) "./euphrates/list-combinations.scm"

(assert=HS '(() (1) (2) (1 2) (3) (1 3) (2 3) (1 2 3) (4) (1 4) (2 4) (1 2 4) (3 4) (1 3 4) (2 3 4) (1 2 3 4))
           (list-combinations (list 1 2 3 4)))

(assert=HS '((1 2) (1 3) (2 3) (1 4) (2 4) (3 4))
           (list-combinations (list 1 2 3 4) 2))

(assert=HS '((1 1) (1 2) (1 3) (1 4) (2 1) (2 2) (2 3) (2 4) (3 1) (3 2) (3 3) (3 4) (4 1) (4 2) (4 3) (4 4))
           (list-combinations (list 1 2 3 4) 2 #t))

(assert=HS '((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0) (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1) (1 1 1 0) (1 1 1 1))
           (list-combinations (list 0 1) 4 #t))
