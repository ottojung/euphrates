
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates vector-random-shuffle-bang)
           vector-random-shuffle!))
   (import
     (only (euphrates with-randomizer-seed)
           with-randomizer-seed))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           make-vector
           quote
           vector-set!))))



(let () ;; vector-random-shuffle!
  (with-randomizer-seed
   1234
   (let ((v (make-vector 4)))
     (vector-set! v 0 'a)
     (vector-set! v 1 'b)
     (vector-set! v 2 'c)
     (vector-set! v 3 'd)

     (assert= #(a b c d) v)
     (vector-random-shuffle! v)
     (assert= #(a c b d) v)
     (vector-random-shuffle! v)
     (assert= #(b d a c) v)
     (vector-random-shuffle! v)
     (assert= #(c a d b) v))))
