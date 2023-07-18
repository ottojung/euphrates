
(define-library
  (test-serialization-short)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates serialization-short)
          deserialize/short
          serialize/short))
  (import
    (only (scheme base)
          begin
          cond-expand
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
