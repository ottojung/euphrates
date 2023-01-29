
(cond-expand
 (guile
  (define-module (euphrates box)
    :export (make-box box? box-ref box-set!))))


(cond-expand
 (guile

  (use-modules (srfi srfi-111))

  (define make-box (@ (srfi srfi-111) box))
  (define box? (@ (srfi srfi-111) box?))
  (define box-ref (@ (srfi srfi-111) unbox))
  (define box-set! (@ (srfi srfi-111) set-box!))

  )
 (racket

  (define make-box box)
  (define box? box?)
  (define box-ref unbox)
  (define box-set! set-box!)

  ))


