
%run guile

%var queue
%var queue?
%var queue-vector
%var queue-first
%var queue-last
%var set-queue-vector!
%var set-queue-first!
%var set-queue-last!

%use (define-dumb-record) "./define-dumb-record.scm"

(define-dumb-record <queue>
  (queue vector first last) queue?
  (vector queue-vector set-queue-vector!)
  (first queue-first set-queue-first!)
  (last queue-last set-queue-last!)
  )
