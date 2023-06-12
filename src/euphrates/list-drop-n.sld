
(define-library
  (euphrates list-drop-n)
  (export list-drop-n)
  (import
    (only (scheme base)
          -
          >=
          begin
          cdr
          define
          if
          let
          null?
          or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-drop-n.scm")))
    (else (include "list-drop-n.scm"))))
