
(define-library
  (euphrates lalr-parser-load)
  (export lalr-parser-load)
  (import
    (only (euphrates lalr-parser-struct)
          make-lalr-parser-struct))
  (import
    (only (euphrates lalr-parser)
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
               "euphrates/lalr-parser-load.scm")))
    (else (include "lalr-parser-load.scm"))))
