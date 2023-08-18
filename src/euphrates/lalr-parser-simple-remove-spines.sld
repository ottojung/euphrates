
(define-library
  (euphrates lalr-parser-simple-remove-spines)
  (export lalr-parser/simple-remove-spines)
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (scheme base)
          and
          begin
          cadr
          car
          cond
          define
          else
          equal?
          let
          list
          list?
          map
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-remove-spines.scm")))
    (else (include "lalr-parser-simple-remove-spines.scm"))))
