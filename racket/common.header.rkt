#lang racket

(require syntax/parse/define
         (for-syntax racket/base
                     racket/syntax))

(define 1+ add1)
(define 1- sub1)

(define [throw type . args]
  (error (symbol->string type) "(args: ~a)" args))

(define [catch-any body handler]
  (call-with-exception-handler handler body))

(define [make-hash-table] (make-hash))

(define [my-make-mutex]
  (make-semaphore 1))

(define [my-mutex-lock! mut]
  (semaphore-wait mut))

(define [my-mutex-unlock! mut]
  (semaphore-post mut))

(define cons* list*)

(define [call-with-blocked-asyncs thunk]
  ;; TODO: print system message that this does not work
  (thunk))

(define [time-get-monotonic-nanoseconds-timestamp]
  (* 1000 1000
     (current-process-milliseconds)))

(define [get-u8 from] (read-byte from))
(define [put-u8 to byte] (write-byte byte to))

(define fold foldl)

