
(define-library
  (euphrates box)
  (export make-box box? box-ref box-set!)
  (import (only (scheme base) begin define))
  (cond-expand
    (racket
      (begin
        (define make-box box)
        (define box? box?)
        (define box-ref unbox)
        (define box-set! set-box!)))
    (guile (import (only (guile) include-from-path))
           (import
             (rename
               (srfi srfi-111)
               (box? is-srfi-111-box-huh?))
             (only (srfi srfi-111) box set-box! unbox))
           (begin (include-from-path "euphrates/box.scm")))
    (else (import
            (rename (srfi 111) (box? is-srfi-111-box-huh?))
            (only (srfi 111) box set-box! unbox))
          (include "box.scm"))))
