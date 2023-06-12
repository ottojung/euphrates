
(define-library
  (euphrates path-normalize)
  (export path-normalize)
  (import
    (only (euphrates list-drop-while)
          list-drop-while)
    (only (euphrates string-split-simple)
          string-split/simple)
    (only (srfi srfi-13)
          string-join
          string-null?
          string-prefix?)
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          equal?
          if
          lambda
          let
          let*
          not
          null?
          or
          quote
          reverse
          string-append)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-normalize.scm")))
    (else (include "path-normalize.scm"))))
