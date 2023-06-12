
(define-library
  (test-serialization-human)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates hashset) list->hashset)
    (only (euphrates serialization-human)
          deserialize/human
          serialize/human)
    (only (scheme base)
          begin
          cons
          define
          eq?
          equal?
          list
          not
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-serialization-human.scm")))
    (else (include "test-serialization-human.scm"))))
