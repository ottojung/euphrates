
(define-library
  (test-list-reduce/pairwise)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-reduce-pairwise)
          list-reduce/pairwise))
  (import
    (only (scheme base)
          >
          begin
          equal?
          if
          lambda
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-reduce-pairwise.scm")))
    (else (include "test-list-reduce-pairwise.scm"))))
