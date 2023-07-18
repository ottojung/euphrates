
(define-library
  (test-serialization-human)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates hashset) list->hashset))
  (import
    (only (euphrates serialization-human)
          deserialize/human
          serialize/human))
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
               "test-serialization-human.scm")))
    (else (include "test-serialization-human.scm"))))
