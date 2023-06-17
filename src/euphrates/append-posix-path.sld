
(define-library
  (euphrates append-posix-path)
  (export append-posix-path)
  (import
    (only (euphrates absolute-posix-path-q)
          absolute-posix-path?))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates remove-common-prefix)
          remove-common-prefix))
  (import
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
