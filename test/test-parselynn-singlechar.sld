
(define-library
  (test-parselynn-singlechar)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates debugs) debugs))
  (import (only (euphrates hashset) make-hashset))
  (import
    (only (euphrates
            parselynn-singlechar-additional-grammar-rules)
          parselynn/singlechar:additional-grammar-rules))
  (import
    (only (euphrates
            parselynn-singlechar-result-as-iterator)
          parselynn/singlechar-result:as-iterator))
  (import
    (only (euphrates parselynn-singlechar-run-on-char-port)
          parselynn/singlechar:run-on-char-port))
  (import
    (only (euphrates parselynn-singlechar-run-on-string)
          parselynn/singlechar:run-on-string))
  (import
    (only (euphrates parselynn-singlechar)
          make-parselynn/singlechar))
  (import
    (only (euphrates parselynn)
          lexical-token-category
          lexical-token-source
          lexical-token-value))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates source-location)
          source-location-column
          source-location-length
          source-location-line
          source-location-offset))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          =
          begin
          cond
          cons
          current-input-port
          define
          else
          equal?
          for-each
          if
          lambda
          length
          let
          port?
          quote
          string?
          vector
          vector-length
          vector-ref))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (srfi srfi-64) test-error)))
    (else (import (only (srfi 64) test-error))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-singlechar.scm")))
    (else (include "test-parselynn-singlechar.scm"))))
