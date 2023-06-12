



(define (linear-interpolate-1d start end t)
  (unless (and (number? t) (<= 0 t) (<= t 1))
    (raisu 't-must-be-a-number-in-range-0-1 start end t))

  (+ (* (- 1 t) start) (* end t)))


(define (linear-interpolate-2d start end t)
  (define x1 (car start))
  (define x2 (car end))
  (define y1 (cdr start))
  (define y2 (cdr end))

  (unless (and (number? t) (<= 0 t) (<= t 1))
    (raisu 't-must-be-a-number-in-range-0-1 start end t))

  (cons (linear-interpolate-1d x1 x2 t)
        (linear-interpolate-1d y1 y2 t)))



