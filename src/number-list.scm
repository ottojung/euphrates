
%run guile

%use (hashmap) "./hashmap.scm"
%use (hashmap-ref hashmap-set!) "./ihashmap.scm"

%var number-list->number
%var number->number-list
%var number-list->number-list

;; `number-list` is `base-q expansion` of a number.
;; It does not support repeated fractions yet.

(define (number-list->number base whole-part fractional-part)
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

(define (number->number-list base x)
  (define-values (whole-part fractional-part)
    (number-parts x))

  (values
   (let loop ((x whole-part) (buf '()))
     (if (zero? x) buf
         (loop
          (quotient x base)
          (cons (remainder x base) buf))))
   (if (zero? fractional-part) '()
       (let ((H (hashmap)))
         (let loop ((x fractional-part))
           (cond
            ((zero? x) '())
            ((hashmap-ref H x #f) '()) ;; TODO: something better?
            (else
             (let ()
               (define mult (* x base))
               (define-values (wp fp) (number-parts mult))
               (hashmap-set! H x #t)
               (cons wp (loop fp))))))))))

(define (number-list->number-list
         inbase outbase whole-part fractional-part)
  (number->number-list
   outbase
   (number-list->number inbase whole-part fractional-part)))

