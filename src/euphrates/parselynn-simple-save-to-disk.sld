
(define-library
  (euphrates parselynn-simple-save-to-disk)
  (export parselynn:simple:save-to-disk)
  (import
    (only (euphrates parselynn-simple-serialize)
          parselynn:simple:serialize))
  (import (only (scheme base) begin define lambda))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-save-to-disk.scm")))
    (else (include "parselynn-simple-save-to-disk.scm"))))
