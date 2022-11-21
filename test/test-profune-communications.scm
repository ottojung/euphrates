
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-op-false) "./src/profun-op-false.scm"
%use (profun-op-less) "./src/profun-op-less.scm"
%use (profun-op*) "./src/profun-op-mult.scm"
%use (profun-op+) "./src/profun-op-plus.scm"
%use (profun-op-separate) "./src/profun-op-separate.scm"
%use (profun-op-sqrt) "./src/profun-op-sqrt.scm"
%use (profun-op-true) "./src/profun-op-true.scm"
%use (profun-op-unify) "./src/profun-op-unify.scm"
%use (profun-create-database) "./src/profun.scm"
%use (make-profune-communicator profune-communicator-handle) "./src/profune-communicator.scm"

(define server-handler
  (profun-make-handler
   (= profun-op-unify)
   (true profun-op-true)
   (false profun-op-false)
   (!= profun-op-separate)
   (+ profun-op+)
   (* profun-op*)
   (sqrt profun-op-sqrt)
   (< profun-op-less)
   ))

(define definitions1
  `(((person "bart"))
    ((person "lisa"))
    ((person "megie"))
    ((person "homer"))
    ((person "marge"))))

(define db1
  (profun-create-database server-handler definitions1))

(let ()
  (define c1
    (make-profune-communicator db1))

  (define got1
    (profune-communicator-handle c1 '(whats (person X))))

  (assert= got1 `(its (equals (((X . "bart"))))))

  (define got2
    (profune-communicator-handle c1 '(more (2))))

  (assert= got2 `(its (equals (((X . "lisa")) ((X . "megie"))))))

  (define got3
    (profune-communicator-handle c1 '(more (100))))

  (assert= got3 `(its (equals (((X . "homer")) ((X . "marge"))))))

  (define got4
    (profune-communicator-handle c1 '(more (50))))

  (assert= got4 `(its (equals ())))

  (define got5
    (profune-communicator-handle c1 '(more (40))))

  (assert= got5 `(its (equals ())))

  )

(let ()
  (define c1
    (make-profune-communicator db1))

  (define got1
    (profune-communicator-handle c1 '(whats (person X) more (2))))

  (assert= got1 `(its (equals (((X . "bart")) ((X . "lisa")) ((X . "megie"))))))

  (define got2
    (profune-communicator-handle c1 '(more (100))))

  (assert= got2 `(its (equals (((X . "homer")) ((X . "marge"))))))

  (define got3
    (profune-communicator-handle c1 '(more (50))))

  (assert= got3 `(its (equals ())))

  (define got4
    (profune-communicator-handle c1 '(more (40))))

  (assert= got4 `(its (equals ())))

  )

(let ()
  (define c1
    (make-profune-communicator db1))

  (define got1
    (profune-communicator-handle c1 '(whats (sqrt X Y) more (2))))

  (assert= got1 '(whats (value (or X Y))))

  (define got2
    (profune-communicator-handle c1 '(its (= X 9))))

  (assert= got2 '(its (equals (((Y . 3) (X . 9))))))

  )


