
(cond-expand
 (guile
  (define-module (euphrates queue-obj)
    :export (queue-constructor queue-predicate queue-vector queue-first queue-last set-queue-vector! set-queue-first! set-queue-last!)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 queue
  (queue-constructor vector first last) queue-predicate
  (vector queue-vector set-queue-vector!)
  (first queue-first set-queue-first!)
  (last queue-last set-queue-last!)
  )
