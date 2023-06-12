
(define-library
  (euphrates with-randomizer-seed)
  (export with-randomizer-seed)
  (import
    (only (euphrates current-random-source-p)
          current-random-source/p)
    (only (euphrates fast-parameterizeable-timestamp-p)
          fast-parameterizeable-timestamp/p)
    (only (euphrates raisu) raisu)
    (only (euphrates srfi-27-generic)
          make-random-source
          random-source-randomize!)
    (only (euphrates
            time-get-fast-parameterizeable-timestamp)
          time-get-fast-parameterizeable-timestamp)
    (only (scheme base)
          +
          -
          <
          _
          begin
          define-syntax
          equal?
          if
          integer?
          let
          parameterize
          quote
          syntax-rules
          unless)
    (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-randomizer-seed.scm")))
    (else (include "with-randomizer-seed.scm"))))
