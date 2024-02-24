
(define-library
  (euphrates list-annihilate)
  (export list-annihilate)
  (import
    (only (euphrates list-reduce-pairwise)
          list-reduce/pairwise))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (scheme base) begin define if lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-annihilate.scm")))
    (else (include "list-annihilate.scm"))))
