
%run guile

%var queue-constructor
%var queue-predicate
%var queue-vector
%var queue-first
%var queue-last
%var set-queue-vector!
%var set-queue-first!
%var set-queue-last!

%use (define-type9) "./define-type9.scm"

(define-type9 queue
  (queue-constructor vector first last) queue-predicate
  (vector queue-vector set-queue-vector!)
  (first queue-first set-queue-first!)
  (last queue-last set-queue-last!)
  )
