



(define-type9 queue
  (queue-constructor vector first last) queue-predicate
  (vector queue-vector set-queue-vector!)
  (first queue-first set-queue-first!)
  (last queue-last set-queue-last!)
  )
