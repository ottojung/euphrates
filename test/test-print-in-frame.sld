
(define-library
  (test-print-in-frame)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import
    (only (euphrates print-in-frame) print-in-frame))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          begin
          cond-expand
          let
          newline))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-print-in-frame.scm")))
    (else (include "test-print-in-frame.scm"))))
