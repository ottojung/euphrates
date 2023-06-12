
(define-library
  (test-serialization-short)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates define-type9) define-type9)
    (only (euphrates hashset) list->hashset)
    (only (euphrates serialization-short)
          deserialize/short
          serialize/short)
    (only (scheme base)
          begin
          define
          eq?
          equal?
          not
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-serialization-short.scm")))
    (else (include "test-serialization-short.scm"))))
