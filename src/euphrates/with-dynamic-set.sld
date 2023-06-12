
(define-library
  (euphrates with-dynamic-set)
  (export with-dynamic-set!)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          if
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) parameter?))
           (begin
             (include-from-path
               "euphrates/with-dynamic-set.scm")))
    (else (include "with-dynamic-set.scm"))))
