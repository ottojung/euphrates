
(define-library
  (test-random-choice)
  (import
    (only (euphrates assert) assert)
    (only (euphrates printable-alphabet)
          printable/alphabet)
    (only (euphrates random-choice) random-choice)
    (only (scheme base)
          begin
          equal?
          let
          list->string
          string-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-random-choice.scm")))
    (else (include "test-random-choice.scm"))))
