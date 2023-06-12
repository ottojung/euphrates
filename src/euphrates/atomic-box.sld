
(define-library
    (euphrates atomic-box)

  (export
   make-atomic-box
   atomic-box?
   atomic-box-ref
   atomic-box-set!
   atomic-box-compare-and-set!)

  (import
   (only (euphrates box) box?)
   (only (scheme base)
         begin
         cond-expand
         define
         eq?
         let)
   (only (srfi srfi-111) box set-box! unbox))

  (cond-expand

   (guile
    (import (guile))
    (import (ice-9 atomic))
    (begin

      (define make-atomic-box (@ (ice-9 atomic) make-atomic-box))
      (define atomic-box? (@ (ice-9 atomic) atomic-box?))
      (define atomic-box-ref (@ (ice-9 atomic) atomic-box-ref))
      (define atomic-box-set! (@ (ice-9 atomic) atomic-box-set!))

      (define (atomic-box-compare-and-set! box expected desired)
        (let ((ret (atomic-box-compare-and-swap! box expected desired)))
          (eq? ret expected)))))

   (racket
    (begin
      (define make-atomic-box box)
      (define atomic-box? box?)
      (define atomic-box-ref unbox)
      (define atomic-box-set! set-box!)
      (define atomic-box-compare-and-set! box-cas!)))))
