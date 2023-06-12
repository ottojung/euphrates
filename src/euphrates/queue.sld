
(define-library
  (euphrates queue)
  (export
    make-queue
    queue?
    queue-empty?
    queue-peek
    queue-push!
    queue-pop!
    list->queue
    queue->list
    queue-unload!
    queue-rotate!
    queue-peek-rotate!)
  (import
    (only (euphrates queue-obj)
          queue-constructor
          queue-first
          queue-last
          queue-predicate
          queue-vector
          set-queue-first!
          set-queue-last!
          set-queue-vector!)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          *
          +
          -
          <
          =
          >=
          begin
          cond
          cons
          define
          else
          if
          length
          let
          let*
          list->vector
          make-vector
          not
          quote
          unless
          vector-fill!
          vector-length
          vector-ref
          vector-set!
          vector?
          when)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-1) first last))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/queue.scm")))
    (else (include "queue.scm"))))
