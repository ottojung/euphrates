
(define-library
  (euphrates list-span-while)
  (export list-span-while)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          not
          null?
          or
          quote
          reverse
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-span-while.scm")))
    (else (include "list-span-while.scm"))))
