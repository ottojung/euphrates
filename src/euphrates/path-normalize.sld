
(define-library
  (euphrates path-normalize)
  (export path-normalize)
  (import
    (only (euphrates list-drop-while)
          list-drop-while))
  (import
    (only (euphrates string-split-simple)
          string-split/simple))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          cons
          define
          else
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
          string-append))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import
             (only (srfi srfi-13)
                   string-join
                   string-null?
                   string-prefix?)))
    (else (import
            (only (srfi 13)
                  string-join
                  string-null?
                  string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/path-normalize.scm")))
    (else (include "path-normalize.scm"))))
