
(define-library
  (euphrates
    labelinglogic-check-bindings)
  (export labelinglogic::check-bindings)
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-has?))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-get-duplicates)
          list-get-duplicates))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          =
          begin
          cadr
          car
          cdr
          cond
          define
          else
          equal?
          for-each
          lambda
          list
          list?
          map
          null?
          pair?
          quote
          symbol?
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-check-bindings.scm")))
    (else (include
            "labelinglogic-check-bindings.scm"))))
