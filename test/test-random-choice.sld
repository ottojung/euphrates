
(define-library
  (test-random-choice)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates printable-alphabet)
          printable/alphabet))
  (import
    (only (euphrates random-choice) random-choice))
  (import
    (only (scheme base)
          begin
          cond-expand
          equal?
          let
          list->string
          string-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-random-choice.scm")))
    (else (include "test-random-choice.scm"))))
