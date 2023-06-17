
(define-library
  (euphrates profun-make-instantiation-test)
  (export profun-make-instantiation-check)
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates profun-query-get-free-variables)
          profun-query-get-free-variables))
  (import
    (only (scheme base) assq begin define lambda let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-make-instantiation-test.scm")))
    (else (include "profun-make-instantiation-test.scm"))))
