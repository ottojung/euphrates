
(define-library
  (test-parselynn-latin)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates parselynn-latin-digits)
          parselynn:latin/digits))
  (import
    (only (euphrates parselynn-latin-letters)
          parselynn:latin/letters))
  (import
    (only (euphrates parselynn-latin-tokens)
          parselynn:latin-tokens))
  (import
    (only (euphrates parselynn-latin)
          make-parselynn:latin))
  (import
    (only (euphrates parselynn-run) parselynn-run))
  (import
    (only (scheme base)
          begin
          define
          list
          quasiquote
          quote
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-latin.scm")))
    (else (include "test-parselynn-latin.scm"))))
