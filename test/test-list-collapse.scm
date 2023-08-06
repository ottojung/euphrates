
(assert=
 '(1 2 3 4 5)
 (list-collapse '(1 (2 3) (4 5))))

(assert=
 '()
 (list-collapse '()))

(assert=
 '(1 2 3 4 5 6 7 8 9 10)
 (list-collapse '(1 (2 (3 (4 (5 (6 (7 (8 (9 10)))))))))))

(assert=
 '(1 2 3 4 5 6 7 8 9 10)
 (list-collapse '((1 2) (3 4) (5 6) (7 8) (9 10))))
