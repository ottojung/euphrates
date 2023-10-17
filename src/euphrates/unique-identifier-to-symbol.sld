
(define-library
  (euphrates unique-identifier-to-symbol)
  (export unique-identifier->symbol)
  (import
    (only (euphrates unique-identifier-to-string)
          unique-identifier->string))
  (import
    (only (scheme base) begin define string->symbol))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/unique-identifier-to-symbol.scm")))
    (else (include "unique-identifier-to-symbol.scm"))))
