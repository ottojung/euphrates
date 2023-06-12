
(define-library
  (euphrates path-extensions)
  (export path-extensions)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet/index)
    (only (euphrates list-and-map) list-and-map)
    (only (euphrates string-split-simple)
          string-split/simple)
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          if
          let
          let*
          null?
          or
          reverse
          string->list
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-extensions.scm")))
    (else (include "path-extensions.scm"))))
