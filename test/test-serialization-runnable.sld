
(define-library
  (test-serialization-runnable)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates hashset) list->hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates serialization-runnable)
          deserialize/runnable
          serialize/runnable))
  (import
    (only (scheme base)
          begin
          cond-expand
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
