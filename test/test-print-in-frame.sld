
(define-library
  (test-print-in-frame)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-intersperse)
          list-intersperse)
    (only (euphrates print-in-frame) print-in-frame)
    (only (euphrates string-to-words) string->words)
    (only (euphrates with-output-to-string)
          with-output-to-string)
    (only (scheme base) _ begin lambda let newline))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-print-in-frame.scm")))
    (else (include "test-print-in-frame.scm"))))
