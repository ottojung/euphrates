
(define-library
  (test-list-count)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates list-count) list-count))
  (import
    (only (scheme base)
          <
          =
          >
          begin
          define
          even?
          lambda
          list
          negative?
          odd?
          positive?
          quote
          zero?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-count.scm")))
    (else (include "test-list-count.scm"))))
