
(define-library
  (euphrates debugv)
  (export debugv)
  (import (only (euphrates const) const))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          _
          apply
          begin
          define
          define-syntax
          length
          map
          quote
          reverse
          string-append
          syntax-rules))
  (cond-expand
    (guile (import (only (srfi srfi-1) count)))
    (else (import (only (srfi 1) count))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/debugv.scm")))
    (else (include "debugv.scm"))))
