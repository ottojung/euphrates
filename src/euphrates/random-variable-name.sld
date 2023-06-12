
(define-library
  (euphrates random-variable-name)
  (export random-variable-name)
  (import
    (only (euphrates alpha-lowercase-alphabet)
          alpha-lowercase/alphabet)
    (only (euphrates alphanum-lowercase-alphabet)
          alphanum-lowercase/alphabet)
    (only (euphrates big-random-int) big-random-int)
    (only (euphrates raisu) raisu)
    (only (euphrates random-choice) random-choice)
    (only (scheme base)
          -
          <
          and
          begin
          cons
          define
          integer?
          list->string
          quote
          unless
          vector-length
          vector-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/random-variable-name.scm")))
    (else (include "random-variable-name.scm"))))
