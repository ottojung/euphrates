
(define-library
  (euphrates list-levenshtein-distance)
  (export list-levenshtein-distance)
  (import
    (only (scheme base)
          +
          begin
          car
          cdr
          cond
          define
          else
          equal?
          length
          let
          min
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-levenshtein-distance.scm")))
    (else (include "list-levenshtein-distance.scm"))))
