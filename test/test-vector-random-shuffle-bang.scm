
(cond-expand
 (guile
  (define-module (test-vector-random-shuffle-bang)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates vector-random-shuffle-bang) :select (vector-random-shuffle!))
    :use-module ((euphrates with-randomizer-seed) :select (with-randomizer-seed)))))


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
