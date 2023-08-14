
(define-library
  (test-with-string-as-input)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          *
          +
          begin
          eof-object?
          list
          quote
          read-char))
  (import (only (scheme read) read))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-with-string-as-input.scm")))
    (else (include "test-with-string-as-input.scm"))))
