
(cond-expand
 (guile
  (define-module (test-list-random-shuffle)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates list-random-shuffle) :select (list-random-shuffle))
    :use-module ((euphrates with-randomizer-seed) :select (with-randomizer-seed)))))


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
