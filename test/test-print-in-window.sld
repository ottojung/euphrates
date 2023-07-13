
(define-library
  (test-print-in-window)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-intersperse)
          list-intersperse)
    (only (euphrates print-in-window)
          print-in-window)
    (only (euphrates string-to-words) string->words)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base) _ begin lambda let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-print-in-window.scm")))
    (else (include "test-print-in-window.scm"))))
