
(define-library
  (euphrates srfi-27-random-source-obj)
  (export
    :random-source-make
    :random-source?
    :random-source-state-ref
    :random-source-state-set!
    :random-source-randomize!
    :random-source-pseudo-randomize!
    :random-source-make-integers
    :random-source-make-reals
    :random-source-current-time)
  (import
    (only (euphrates
            time-get-fast-parameterizeable-timestamp)
          time-get-fast-parameterizeable-timestamp))
  (import
    (only (scheme base)
          =
          and
          begin
          define
          vector
          vector-length
          vector-ref
          vector?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/srfi-27-random-source-obj.scm")))
    (else (include "srfi-27-random-source-obj.scm"))))
