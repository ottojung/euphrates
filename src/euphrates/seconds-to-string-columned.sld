
(define-library
  (euphrates seconds-to-string-columned)
  (export seconds->string-columned)
  (import (only (euphrates comp) appcomp comp))
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import
    (only (euphrates list-drop-while)
          list-drop-while))
  (import
    (only (euphrates list-take-n) list-take-n))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates string-pad) string-pad-L))
  (import
    (only (scheme base)
          *
          -
          /
          =
          append
          apply
          begin
          cdr
          define
          define-values
          equal?
          exact
          floor
          if
          inexact
          integer?
          list
          list->string
          map
          number->string
          reverse
          string->list
          string-append
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter second)))
    (else (import (only (srfi 1) filter second))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/seconds-to-string-columned.scm")))
    (else (include "seconds-to-string-columned.scm"))))
