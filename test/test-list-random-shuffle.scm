
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (list-random-shuffle) "./euphrates/list-random-shuffle.scm"
%use (with-randomizer-seed) "./euphrates/with-randomizer-seed.scm"

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
