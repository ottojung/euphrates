
(define-library
  (test-serialization-runnable)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates hashset) list->hashset)
    (only (euphrates identity) identity)
    (only (euphrates serialization-runnable)
          deserialize/runnable
          serialize/runnable)
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
               "test-serialization-runnable.scm")))
    (else (include "test-serialization-runnable.scm"))))
