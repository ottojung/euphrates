
(define-library
  (test-catchu-case)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates dprintln) dprintln))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          _
          apply
          begin
          cond-expand
          cons
          current-error-port
          define-syntax
          equal?
          let
          newline
          not
          quote
          syntax-rules
          unless))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-catchu-case.scm")))
    (else (include "test-catchu-case.scm"))))
