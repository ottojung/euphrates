
(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= (list 'uid 1) (unique-identifier->list u1))
   (assert= (list 'uid 2) (unique-identifier->list u2))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= (list 'uid 1) (unique-identifier->list u1))
   (assert= (list 'uid 2) (unique-identifier->list u2)))

  (with-unique-identifier-context
   (assert= (list 'uid 1) (unique-identifier->list u3))
   (assert= (list 'uid 2) (unique-identifier->list u4))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= (list 'uid 1) (unique-identifier->list u1))
   (assert= (list 'uid 2) (unique-identifier->list u2))
   (assert= (list 'uid 3) (unique-identifier->list u3))
   (assert= (list 'uid 4) (unique-identifier->list u4))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= (list 'uid 1) (unique-identifier->list u1))
   (assert= (list 'uid 2) (unique-identifier->list u2))
   (assert= (list 'uid 3) (unique-identifier->list u3))
   (assert= (list 'uid 2) (unique-identifier->list u2))
   (assert= (list 'uid 2) (unique-identifier->list u2))
   (assert= (list 'uid 2) (unique-identifier->list u2))
   (assert= (list 'uid 4) (unique-identifier->list u4))))

(let ()
  (define u1 (make-unique-identifier))

  (assert-throw
   'must-begin-serialization-first
   (unique-identifier->list u1)))
