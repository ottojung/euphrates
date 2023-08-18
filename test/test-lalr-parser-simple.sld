
(define-library
  (test-lalr-parser-simple)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates lalr-parser-simple)
          lalr-parser/simple))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          /
          =
          begin
          car
          cdr
          define
          list
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-simple.scm")))
    (else (include "test-lalr-parser-simple.scm"))))
