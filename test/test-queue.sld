
(define-library
  (test-queue)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates queue)
          make-queue
          queue->list
          queue-empty?
          queue-peek
          queue-pop!
          queue-push!)
    (only (scheme base) begin define not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-queue.scm")))
    (else (include "test-queue.scm"))))
