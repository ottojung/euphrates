
(define-library
  (test-define-type9)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates define-type9)
          define-type9
          type9-get-record-descriptor))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          assoc
          begin
          cdr
          cond-expand
          define
          eq?
          not
          quote))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-define-type9.scm")))
    (else (include "test-define-type9.scm"))))
