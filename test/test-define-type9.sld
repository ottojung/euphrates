
(define-library
  (test-define-type9)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates define-type9)
          define-type9
          type9-get-record-descriptor)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          _
          assoc
          begin
          cdr
          define
          eq?
          lambda
          not
          quote)
    (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-define-type9.scm")))
    (else (include "test-define-type9.scm"))))
