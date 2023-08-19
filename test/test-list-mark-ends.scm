
;; Test with an empty list
(assert= (list-mark-ends '()) '())

;; Test with a single-element list
(assert= (list-mark-ends '(1)) '((#t #t 1)))

;; Test with a two-element list
(assert= (list-mark-ends '(1 2)) '((#t #f 1) (#f #t 2)))

;; Test with a three-element list
(assert= (list-mark-ends '("A" "B" "C")) '((#t #f "A") (#f #f "B") (#f #t "C")))

;; Test with multiple identical elements
(assert= (list-mark-ends '(5 5 5 5)) '((#t #f 5) (#f #f 5) (#f #f 5) (#f #t 5)))

;; Test with mixed types
(assert= (list-mark-ends '(1 "B" #\C)) '((#t #f 1) (#f #f "B") (#f #t #\C)))

;; Test with nested lists
(assert= (list-mark-ends '((1) (2 3) (4))) '((#t #f (1)) (#f #f (2 3)) (#f #t (4))))

;; Test with boolean values
(assert= (list-mark-ends '(#t #f #t #f)) '((#t #f #t) (#f #f #f) (#f #f #t) (#f #t #f)))

;; Test with symbols
(assert= (list-mark-ends '(:a :b :c)) '((#t #f :a) (#f #f :b) (#f #t :c)))

;; Test with numbers and characters
(assert= (list-mark-ends '(1 #\A 2 #\B 3)) '((#t #f 1) (#f #f #\A) (#f #f 2) (#f #f #\B) (#f #t 3)))

;; Test with a large list
(assert= (list-mark-ends (iota 10)) '((#t #f 0) (#f #f 1) (#f #f 2) (#f #f 3) (#f #f 4) (#f #f 5) (#f #f 6) (#f #f 7) (#f #f 8) (#f #t 9)))

;; Test with a list containing a single false boolean value
(assert= (list-mark-ends '(#f)) '((#t #t #f)))

;; Test with a list containing a single true boolean value
(assert= (list-mark-ends '(#t)) '((#t #t #t)))

;; Test with a list containing a single empty string
(assert= (list-mark-ends '("")) '((#t #t "")))

;; Test with a list containing a single empty list
(assert= (list-mark-ends '(())) '((#t #t ())))

;; Test with a list containing a single character
(assert= (list-mark-ends '(#\a)) '((#t #t #\a)))

;; Test with a list containing multiple single characters
(assert= (list-mark-ends '(#\a #\b #\c)) '((#t #f #\a) (#f #f #\b) (#f #t #\c)))

;; Test with a list containing multiple empty strings
(assert= (list-mark-ends '("" "" "" "")) '((#t #f "") (#f #f "") (#f #f "") (#f #t "")))

;; Test with a list containing multiple empty lists
(assert= (list-mark-ends '(() () () ())) '((#t #f ()) (#f #f ()) (#f #f ()) (#f #t ())))
