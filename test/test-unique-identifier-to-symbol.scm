
(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= 'uid_1 (unique-identifier->symbol u1))
   (assert= 'uid_2 (unique-identifier->symbol u2))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= 'uid_1 (unique-identifier->symbol u1))
   (assert= 'uid_2 (unique-identifier->symbol u2)))

  (with-unique-identifier-context
   (assert= 'uid_1 (unique-identifier->symbol u3))
   (assert= 'uid_2 (unique-identifier->symbol u4))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= 'uid_1 (unique-identifier->symbol u1))
   (assert= 'uid_2 (unique-identifier->symbol u2))
   (assert= 'uid_3 (unique-identifier->symbol u3))
   (assert= 'uid_4 (unique-identifier->symbol u4))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   (assert= 'uid_1 (unique-identifier->symbol u1))
   (assert= 'uid_2 (unique-identifier->symbol u2))
   (assert= 'uid_3 (unique-identifier->symbol u3))
   (assert= 'uid_2 (unique-identifier->symbol u2))
   (assert= 'uid_2 (unique-identifier->symbol u2))
   (assert= 'uid_2 (unique-identifier->symbol u2))
   (assert= 'uid_4 (unique-identifier->symbol u4))))

(let ()
  (define u1 (make-unique-identifier))

  (assert-throw
   'must-begin-serialization-first
   (unique-identifier->symbol u1)))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (assert= 'uid_2 (unique-identifier->symbol u1))
   (assert= 'uid_4 (unique-identifier->symbol u2))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (with-unique-identifier-context
    :existing-names (list 'uid_2)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2)))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (with-unique-identifier-context
    :existing-names (list 'uid_2)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2)))

   (with-unique-identifier-context
    :existing-names (list 'uid_5)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2)))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (assert= 'uid_2 (unique-identifier->symbol u3))

   (with-unique-identifier-context
    :existing-names (list 'uid_2)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3))
    (assert= 'uid_6 (unique-identifier->symbol u4)))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (assert= 'uid_2 (unique-identifier->symbol u3))

   (with-unique-identifier-context
    :existing-names (list 'uid_2)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3))
    (assert= 'uid_6 (unique-identifier->symbol u4)))

   (with-unique-identifier-context
    :existing-names (list 'uid_5)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3))
    (assert= 'uid_6 (unique-identifier->symbol u4)))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (assert= 'uid_2 (unique-identifier->symbol u3))

   (with-unique-identifier-context
    :existing-names (list 'uid_2)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3)))

   (with-unique-identifier-context
    :existing-names (list 'uid_6)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3))
    (assert= 'uid_7 (unique-identifier->symbol u4)))))

(let ()
  (define u1 (make-unique-identifier))
  (define u2 (make-unique-identifier))
  (define u3 (make-unique-identifier))
  (define u4 (make-unique-identifier))

  (with-unique-identifier-context
   :existing-names (list 'uid_1 'uid_3)

   (assert= 'uid_2 (unique-identifier->symbol u3))

   (with-unique-identifier-context
    :existing-names (list 'uid_6)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3)))

   (with-unique-identifier-context
    :existing-names (list 'uid_8)

    (assert= 'uid_4 (unique-identifier->symbol u1))
    (assert= 'uid_5 (unique-identifier->symbol u2))
    (assert= 'uid_2 (unique-identifier->symbol u3))
    (assert= 'uid_7 (unique-identifier->symbol u4)))))
