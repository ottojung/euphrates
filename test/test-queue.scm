
(cond-expand
  (guile)
  ((not guile)
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
           quote))))


;; queue

(define q (make-queue 1))
(assert= '() (queue->list q))

(queue-push! q 1)
(queue-push! q 2)
(queue-push! q 3)

(assert= '(1 2 3) (queue->list q))

(assert= (queue-peek q) 1)
(assert= '(1 2 3) (queue->list q))

(assert= (queue-pop! q) 1)
(assert= '(2 3) (queue->list q))

(assert= (queue-peek q) 2)
(assert= '(2 3) (queue->list q))

(assert= (queue-pop! q) 2)
(assert= '(3) (queue->list q))

(assert (not (queue-empty? q)))

(queue-push! q 9)
(assert= '(3 9) (queue->list q))

(assert= (queue-pop! q) 3)
(assert= '(9) (queue->list q))

(queue-push! q 8)
(assert= '(9 8) (queue->list q))

(assert= (queue-pop! q) 9)
(assert= '(8) (queue->list q))

(queue-push! q 7)
(assert= '(8 7) (queue->list q))

(assert= (queue-pop! q) 8)
(assert= '(7) (queue->list q))

(assert= (queue-pop! q) 7)
(assert= '() (queue->list q))

(assert (queue-empty? q))
