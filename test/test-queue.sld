
(define-library
  (test-queue)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates queue)
          make-queue
          queue->list
          queue-empty?
          queue-peek
          queue-pop!
          queue-push!))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          not
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-queue.scm")))
    (else (include "test-queue.scm"))))
