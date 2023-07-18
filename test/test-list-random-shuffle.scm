
(cond-expand
  (guile)
  ((not guile)
   (import (only (euphrates assert-equal) assert=))
   (import
     (only (euphrates list-random-shuffle)
           list-random-shuffle))
   (import
     (only (euphrates with-randomizer-seed)
           with-randomizer-seed))
   (import
     (only (scheme base)
           begin
           cond-expand
           let
           quote
           set!))))



(let () ;; list-random-shuffle
  (with-randomizer-seed
   1234
   (let ((L '(a b c d)))
     (assert= '(a b c d) L)
     (set! L (list-random-shuffle L))
     (assert= '(a c b d) L)
     (set! L (list-random-shuffle L))
     (assert= '(b d a c) L)
     (set! L (list-random-shuffle L))
     (assert= '(c a d b) L))))
