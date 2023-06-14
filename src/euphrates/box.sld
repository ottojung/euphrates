
(define-library
    (euphrates box)
  (export make-box box? box-ref box-set!)
  (import
   (only (scheme base) begin cond-expand define))
  (cond-expand
   (guile
    (import (rename (srfi srfi-111) (box? is-srfi-111-box-huh?))
            (only (srfi srfi-111) box set-box! unbox))
    (begin
      (define make-box box)
      (define box? is-srfi-111-box-huh?)
      (define box-ref unbox)
      (define box-set! set-box!)
      ))
   (racket
    (begin
      (define make-box box)
      (define box? box?)
      (define box-ref unbox)
      (define box-set! set-box!)
      ))))
