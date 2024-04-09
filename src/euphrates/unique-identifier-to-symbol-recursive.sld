
(define-library
  (euphrates unique-identifier-to-symbol-recursive)
  (export unique-identifier->symbol/recursive)
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates unique-identifier-to-symbol)
          unique-identifier->symbol))
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base)
          begin
          car
          cdr
          char?
          cond
          cons
          define
          else
          eof-object?
          equal?
          let
          list
          null?
          number?
          pair?
          procedure?
          quote
          string?
          vector-map
          vector?
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/unique-identifier-to-symbol-recursive.scm")))
    (else (include
            "unique-identifier-to-symbol-recursive.scm"))))
