
;; Simple list and increment function
(assert= '(2 3 4 5)
         (list-map/deep (lambda (x) (+ x 1)) '(1 2 3 4)))

;; Nested lists and increment function
(assert=  '(2 (3 4) 5 (6 (7 8)))
          (list-map/deep
           (lambda (x) (+ x 1))
           '(1 (2 3) 4 (5 (6 7)))))

;; Empty list
(assert= '() (list-map/deep
              (lambda (x) (* x 2)) '()))

;; Non-list input
(assert-throw 'not-a-list
              (list-map/deep (lambda (x) (* x 2)) 10))

;; Non-list input 2
(assert-throw 'not-a-list
              (list-map/deep (lambda (x) (* x 2)) (cons 10 20)))

;; Constant function
(assert= '(7 7 7 7)
         (list-map/deep (const 7) '(1 2 3 4)))

;; Pair among leafs
(assert= '(8 8 8 8 8)
         (list-map/deep (const 8) '(1 2 (10 . 20) 3 4)))

;; A complex function
(assert= '((1 1) ((2 2) ((3 3) ((4 4) (5 5)))))
         (list-map/deep (lambda (x) (list x x))
                        '(1 (2 (3 (4 5))))))
