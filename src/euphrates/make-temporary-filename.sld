
(define-library
  (euphrates make-temporary-filename)
  (export make-temporary-filename)
  (import
    (only (euphrates alphanum-alphabet)
          alphanum/alphabet))
  (import
    (only (euphrates random-choice) random-choice))
  (import
    (only (scheme base)
          begin
          define
          let*
          list->string
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/make-temporary-filename.scm")))
    (else (include "make-temporary-filename.scm"))))
