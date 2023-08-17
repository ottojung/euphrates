
(define-library
  (euphrates source-location)
  (export
    make-source-location
    source-location?
    source-location-input
    source-location-line
    source-location-column
    source-location-offset
    source-location-length)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/source-location.scm")))
    (else (include "source-location.scm"))))
