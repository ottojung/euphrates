
(define-library
  (euphrates list-annihilate)
  (export list-annihilate)
  (import (only (euphrates debug) debug))
  (import (only (euphrates debugs) debugs))
  (import
    (only (scheme base)
          +
          -
          <
          begin
          define
          if
          let
          list->vector
          vector->list
          vector-copy
          vector-length
          vector-ref
          vector-set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-annihilate.scm")))
    (else (include "list-annihilate.scm"))))
