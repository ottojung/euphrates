
(define-library
  (euphrates mimetype-extensions)
  (export mimetype/extensions)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/mimetype-extensions.scm")))
    (else (include "mimetype-extensions.scm"))))
