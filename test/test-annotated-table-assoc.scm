
;; Define a sample table for testing
(define sample-table
  '(("Header" "Col1" "Col2" "Col3")
    ("Row1" 1 2 3)
    ("Row2" 4 5 6)
    ("Row3" 7 8 9)))

;; Test case: Valid column and row keys
(assert=
 4
 (annotated-table-assoc "Col1" "Row2" sample-table))

(assert=
 9
 (annotated-table-assoc "Col3" "Row3" sample-table))

(assert=
 2
 (annotated-table-assoc "Col2" "Row1" sample-table))

;; Test case: Invalid row key
(assert-throw
 'cannot-find-row-key
 (annotated-table-assoc "Col1" "Row4" sample-table))

;; Test case: Invalid column key
(assert-throw
 'cannot-find-column-key
 (annotated-table-assoc "Col4" "Row2" sample-table))

;; Test case: Both row and column keys invalid
(assert-throw
 'cannot-find-row-key
 (annotated-table-assoc "Col4" "Row4" sample-table))

;; Test case: Valid row key, invalid column key
(assert-throw
 'cannot-find-column-key
 (annotated-table-assoc "Col4" "Row1" sample-table))

;; Test case: Valid column key, invalid row key
(assert-throw
 'cannot-find-row-key
 (annotated-table-assoc "Col1" "Row4" sample-table))

;; Test case: Column and row keys as numbers
(define sample-table-numeric
  '((0 1 2)
    (1 10 20 30)
    (2 40 50 60)
    (3 70 80 90)))

(assert=
 50
 (annotated-table-assoc 2 2 sample-table-numeric))

(assert-throw
 'cannot-find-column-key
 (annotated-table-assoc 3 2 sample-table-numeric))

(assert-throw
 'cannot-find-row-key
 (annotated-table-assoc 1 4 sample-table-numeric))
