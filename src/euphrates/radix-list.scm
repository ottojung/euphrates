


;; `radix-list` is the `base-q expansion` of a number.

(define (radix-list->number base whole-part fractional-part)
  (+
   (let loop ((whole-part (reverse whole-part))
              (pow 1))
     (if (null? whole-part) 0
         (+ (* pow (car whole-part))
            (loop (cdr whole-part) (* pow base)))))

   (let loop ((whole-part fractional-part)
              (pow (/ 1 base)))
     (if (null? whole-part) 0
         (+ (* pow (car whole-part))
            (loop (cdr whole-part) (/ pow base)))))))

(define (number-parts x0)
  (define x (inexact->exact x0))
  (define fractional-part (- x (floor x)))
  (define whole-part (- x fractional-part))
  (values whole-part fractional-part))

(define number->radix-list:precision/p
  (make-parameter 20))

(define (number->radix-list base x0)
  (define x (inexact->exact x0))

  (define-values (whole-part fractional-part)
    (number-parts x))

  (values
   (let loop ((x whole-part) (buf '()))
     (if (zero? x) buf
         (loop
          (quotient x base)
          (cons (remainder x base) buf))))
   (if (zero? fractional-part) '()
       (let loop ((x fractional-part)
                  (i (number->radix-list:precision/p)))
         (if (or (zero? x)
                 (zero? i))
             '()
             (let ()
               (define mult (* x base))
               (define-values (wp fp) (number-parts mult))
               (cons wp (loop fp (- i 1)))))))))

(define (radix-list->radix-list
         inbase outbase whole-part fractional-part)
  (number->radix-list
   outbase
   (radix-list->number inbase whole-part fractional-part)))

