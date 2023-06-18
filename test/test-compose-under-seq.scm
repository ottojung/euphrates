
;; helpers:
(define (divisible-by-3? x)
  (= 0 (quotient x 3)))

(define (increment x)
  (+ 1 x))

(define (double x)
  (+ x x))

(define (inverse x)
  (- x))



(let ()
  (assert=
   5
   ((compose-under-seq or even? divisible-by-3?) 5))

  ;; Expansion:
  (assert=
   5
   (let ((y
          (let ((x 5))
            (or x (even? x)))))
     (or y (divisible-by-3? y)))))

(assert=
 6 ((compose-under-seq or even? divisible-by-3?) 6))

(assert=
 #f ((compose-under-seq and even? divisible-by-3?) 5))

(assert=
 0 ((compose-under-seq + inverse double) 6))

(assert=
 0 ((compose-under-seq + double inverse) 6))

(let ()
  (assert=
   0
   ((compose-under-seq + increment inverse) 6))

  ;; Expansion:
  (assert=
   0
   (let ((y
          (let ((x 6))
            (+ x (increment x)))))
     (+ y (inverse y)))))

(let ()
  (assert=
   1
   ((compose-under-seq + inverse increment) 6))

  ;; Expansion:
  (assert=
   1
   (let ((y
          (let ((x 6))
            (+ x (inverse x)))))
     (+ y (increment y)))))

(assert=
 2592
 ((compose-under-seq * inverse double) 6))

(let ()
  (assert=
   -5184
   ((compose-under-seq * double inverse) 6))

  ;; Expansion:
  (assert=
   -5184
   (let ((y
          (let ((x 6))
            (* x (double x)))))
     (* y (inverse y)))))
