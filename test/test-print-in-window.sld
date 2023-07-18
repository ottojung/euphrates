
(define-library
  (test-print-in-window)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-intersperse)
          list-intersperse))
  (import
    (only (euphrates print-in-window)
          print-in-window))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-print-in-window.scm")))
    (else (include "test-print-in-window.scm"))))
