
(define-library
  (euphrates list-annihilate)
  (export list-annihilate)
  (import
    (only (euphrates list-reduce-pairwise-left)
          list-reduce/pairwise/left))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (scheme base)
          begin
          define
          equal?
          if
          lambda
          not
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-annihilate.scm")))
    (else (include "list-annihilate.scm"))))
