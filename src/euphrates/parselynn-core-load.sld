
(define-library
  (euphrates parselynn-core-load)
  (export parselynn:core:load)
  (import
    (only (euphrates parselynn-core-serialized-typetag)
          parselynn:core:serialized-typetag))
  (import
    (only (euphrates parselynn-core-struct)
          make-parselynn:core:struct))
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
               "euphrates/parselynn-core-load.scm")))
    (else (include "parselynn-core-load.scm"))))
