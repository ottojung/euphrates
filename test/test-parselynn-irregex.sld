
(define-library
  (test-parselynn-irregex)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates parselynn-irregex)
          make-parselynn/irregex-factory))
  (import
    (only (euphrates parselynn)
          lexical-token-category
          lexical-token-source
          lexical-token-value))
  (import
    (only (euphrates source-location)
          source-location-column
          source-location-length
          source-location-line
          source-location-offset))
  (import
    (only (scheme base)
          begin
          cons
          define
          equal?
          if
          let
          or
          quasiquote
          quote
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-irregex.scm")))
    (else (include "test-parselynn-irregex.scm"))))
