
(define-library
  (euphrates queue-obj)
  (export
    queue-constructor
    queue-predicate
    queue-vector
    queue-first
    queue-last
    set-queue-vector!
    set-queue-first!
    set-queue-last!)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin vector))
  (cond-expand
    (guile (import (only (srfi srfi-1) first last)))
    (else (import (only (srfi 1) first last))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/queue-obj.scm")))
    (else (include "queue-obj.scm"))))
