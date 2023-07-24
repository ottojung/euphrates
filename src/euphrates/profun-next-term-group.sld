
(define-library
  (euphrates profun-next-term-group)
  (export profun-next/term-group)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates profun-abort) profun-abort?))
  (import
    (only (euphrates profun-iterator)
          profun-iterator-query))
  (import (only (euphrates profun) profun-next))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond-expand
          cons
          define
          if
          lambda
          map
          not
          or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-next-term-group.scm")))
    (else (include "profun-next-term-group.scm"))))
