
(define-library
  (euphrates display-alist-as-json)
  (export display-alist-as-json)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates list-mark-ends) list-mark-ends))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          -
          =
          begin
          car
          cdr
          cond
          current-output-port
          define
          else
          equal?
          for-each
          lambda
          let
          list?
          make-string
          newline
          number?
          pair?
          quote
          set!
          string?
          symbol?
          unless
          vector-for-each
          vector?))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/display-alist-as-json.scm")))
    (else (include "display-alist-as-json.scm"))))
