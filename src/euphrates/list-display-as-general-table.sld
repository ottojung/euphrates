
(define-library
  (euphrates list-display-as-general-table)
  (export list:display-as-general-table)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates list-maximal-element-or)
          list-maximal-element-or))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates replicate) replicate))
  (import
    (only (euphrates string-pad) string-pad-L))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          =
          >
          append
          apply
          begin
          car
          current-output-port
          define
          for-each
          lambda
          length
          let
          list
          list-ref
          list?
          map
          newline
          null?
          quote
          string
          string-length
          unless
          values
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-display-as-general-table.scm")))
    (else (include "list-display-as-general-table.scm"))))
