
(define-library
  (euphrates append-posix-path)
  (export append-posix-path)
  (import
    (only (euphrates absolute-posix-path-q)
          absolute-posix-path?)
    (only (euphrates raisu) raisu)
    (only (euphrates remove-common-prefix)
          remove-common-prefix)
    (only (scheme base)
          -
          =
          begin
          car
          cdr
          char=?
          define
          equal?
          if
          let
          null?
          quasiquote
          quote
          string-append
          string-length
          string-ref
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/append-posix-path.scm")))
    (else (include "append-posix-path.scm"))))
