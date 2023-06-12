

;; package

(let ()
  (define already-defined 7)

  (define x
    (with-svars [already-defined]
                (lambda (c) (list already-defined c))))

  (define y
    ((use-svars x (b 2) (already-defined 1)) 4))

  (define z
    ((x) 4))

  (define p
    (make-package [already-defined]
                  [[foo (lambda (c) (list already-defined c))]
                   [bar (lambda (c) (list c already-defined))]
                   [baz 3]]))

  (define p-inst (p (cons 'already-defined 22)))
  (define foo-inst (hashmap-ref p-inst 'foo))

  (assert= y (list 1 4))
  (assert= z (list 7 4))

  (assert=
   (list 22 2)
   (foo-inst 2))

  (assert=
   (list 3 2)
   (with-package
    [p [b 2] [already-defined 3]]
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    p
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    [p]
    [foo bar baz]
    (begin
      (foo 2)))))
