
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
%use (raisu) "./src/raisu.scm"

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

(define (test-dialog sentences)
  (define comm (make-profune-communicator db1))

  (unless (= 0 (remainder (length sentences) 2))
    (raisu 'must-be-even-number-of-sentences (length sentences)))

  (let loop ((sentences sentences))
    (unless (null? sentences)
      (let ()
        (define a (list-ref sentences 0))
        (define b (list-ref sentences 1))
        (define ans
          (profune-communicator-handle comm a))
        (assert= b ans)
        (loop (cdr (cdr sentences)))))))

(test-dialog
 '((whats (sqrt 9 Y))
   (its (equals (((Y . 3)))))
   ))

(test-dialog
 '((whats (= X 9) (sqrt X Y))
   (its (equals (((Y . 3) (X . 9)))))
   ))

(test-dialog
 '((whats (= X 9) (sqrt X Y) more (2))
   (its (equals (((Y . 3) (X . 9)))))
   ))

(test-dialog
 '((whats (= X 9) (sqrt X Y))
   (its (equals (((Y . 3) (X . 9)))))
   (whats (= Y 4) (sqrt X Y))
   (its (equals (((Y . 4) (X . 16)))))
   ))

(test-dialog
 '((whats (sqrt X Y))
   (whats (value (or X Y)))
   (its (= X 9))
   (its (equals (((Y . 3) (X . 9)))))
   ))

(test-dialog
 '((whats (= X 10) (sqrt X Y))
   (its (equals ()))
   ))

(test-dialog
 '((whats (person X))
   (its (equals (((X . "bart")))))
   (more (2))
   (its (equals (((X . "lisa")) ((X . "megie")))))
   (more (100))
   (its (equals (((X . "homer")) ((X . "marge")))))
   (more (50))
   (its (equals ()))
   (more (40))
   (its (equals ()))
   ))

(test-dialog
 '((whats (person X) more (2))
   (its (equals (((X . "bart")) ((X . "lisa")) ((X . "megie")))))
   (more (100))
   (its (equals (((X . "homer")) ((X . "marge")))))
   (more (50))
   (its (equals ()))
   (more (40))
   (its (equals ()))
   ))
