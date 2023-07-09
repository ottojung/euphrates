
(assert #t)

(assert 0)

(assert (not #f))

(assert (= 5 5))

(assert (= (+ 2 4) (* 2 3)))

(assert "true-or-something")

(let ((sym 'true-or-something))
  (assert sym))

(let ()
  (define threw? #f)
  (catch-any
   (lambda _ (assert #f))
   (lambda errors (set! threw? #t)))

  (unless threw?
    (display "Asserted false and did not throw an exception")
    (newline)
    (exit 1)))

(let ()
  (define threw? #f)
  (catch-any
   (lambda _ (assert (= 2 3)))
   (lambda errors (set! threw? #t)))

  (unless threw?
    (display "Asserted false and did not throw an exception")
    (newline)
    (exit 1)))

(let ()
  (define threw? #f)
  (catch-any
   (lambda _ (assert (= (* 2 2) (+ 3 5))))
   (lambda errors (set! threw? #t)))

  (unless threw?
    (display "Asserted false and did not throw an exception")
    (newline)
    (exit 1)))

(let ()
  (define threw? #f)
  (catch-any
   (lambda _ (assert (= (* 2 2) (+ 3 5))))
   (lambda errors
     (unless (equal?
              errors
              '((assertion-fail (test: (= 4 8)) (original: (= (* 2 2) (+ 3 5))))))
       (display "Unexpected error from assert")
       (newline)
       (exit 1)))))
