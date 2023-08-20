
(define-library
  (euphrates display-alist-as-json)
  (export
    display-alist-as-json
    display-alist-as-json/indent
    display-alist-as-json/minimal)
  (import (only (euphrates const) const))
  (import (only (euphrates ignore) ignore))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          -
          _
          begin
          car
          cdr
          cond
          current-output-port
          define
          else
          equal?
          for-each
          if
          lambda
          let
          list
          list?
          make-string
          member
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
