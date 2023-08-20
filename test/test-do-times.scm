
(let ()
  (define state 1)
  (define n 9)
  (do-times n (set! state (* 2 state)))
  (assert= state 256))

(let ()
  (define state 2)
  (define n 0)
  (do-times n (set! state (* 2 state)))
  (assert= state 2))

(let ()
  (define state 1)
  (define n 5)
  (do-times n (set! state (* n state)))
  (assert= state 120))
