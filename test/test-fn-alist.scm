
(cond-expand
 (guile
  (define-module (test-fn-alist)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates fn-alist) :select (fn-alist)))))


(define mult
  (fn-alist (X Y) (+ X Y)))

(assert= 6 (mult `((X . 2) (Y . 4))))
(assert= 7 (mult `((Z . 5) (X . 3) (Y . 4))))
(assert= 8 (mult `((Z . 5) (X . 3) (Y . 5) (M . 9))))
(assert= 9 (mult `((Z . 5) (X . 5) (X . 3) (Y . 4))))
