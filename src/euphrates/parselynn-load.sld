
(define-library
  (euphrates parselynn-load)
  (export parselynn-load)
  (import
    (only (euphrates parselynn-struct)
          make-parselynn-struct))
  (import
    (only (euphrates parselynn)
          serialized-parser-typetag))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          =
          and
          begin
          define
          equal?
          list
          quote
          unless
          vector-length
          vector-ref
          vector?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-load.scm")))
    (else (include "parselynn-load.scm"))))
