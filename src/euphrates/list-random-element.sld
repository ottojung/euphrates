
(define-library
  (euphrates list-random-element)
  (export list-random-element)
  (import
    (only (euphrates big-random-int) big-random-int))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          begin
          define
          length
          let
          list-ref
          null?
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-random-element.scm")))
    (else (include "list-random-element.scm"))))
