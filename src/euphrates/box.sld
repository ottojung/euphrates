
(define-library
    (euphrates box)
  (export make-box box? box-ref box-set!)
  (import
   (only (scheme base) begin cond-expand define))
  (cond-expand
   (guile
    (import (guile))
    (import (only (srfi srfi-111) box set-box! unbox))
    (begin
      (define make-box (@ (srfi srfi-111) box))
      (define box? (@ (srfi srfi-111) box?))
      (define box-ref (@ (srfi srfi-111) unbox))
      (define box-set! (@ (srfi srfi-111) set-box!))
      ))
   (racket
    (begin
      (define make-box box)
      (define box? box?)
      (define box-ref unbox)
      (define box-set! set-box!)
      ))))
