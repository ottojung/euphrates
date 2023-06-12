
(define-library
  (euphrates string-split-3)
  (export string-split-3)
  (import
    (only (euphrates list-drop-n) list-drop-n)
    (only (euphrates list-prefix-q) list-prefix?)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          begin
          car
          cdr
          char?
          cond
          cons
          define
          else
          if
          length
          let
          list
          list->string
          null?
          procedure?
          quote
          reverse
          string->list
          string?
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-split-3.scm")))
    (else (include "string-split-3.scm"))))
