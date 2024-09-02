
(define-library
  (euphrates iterator-to-list)
  (export iterator->list)
  (import
    (only (euphrates iterator) iterator:next))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (scheme base)
          begin
          cons
          define
          eq?
          if
          lambda
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/iterator-to-list.scm")))
    (else (include "iterator-to-list.scm"))))
