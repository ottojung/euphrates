
(define-library
  (euphrates parselynn-token)
  (export
    parselynn:token?
    parselynn:token:make
    parselynn:token:category
    parselynn:token:source
    parselynn:token:value
    parselynn:token:typetag)
  (import
    (only (scheme base)
          =
          and
          begin
          define
          equal?
          quote
          vector
          vector-length
          vector-ref
          vector?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-token.scm")))
    (else (include "parselynn-token.scm"))))
