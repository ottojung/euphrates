
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (debugv) "./src/debugv.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-op-divisible) "./src/profun-op-divisible.scm"
%use (profun-op-equals) "./src/profun-op-equals.scm"
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
   (!= profun-op-separate)
   (true profun-op-true)
   (false profun-op-false)
   (+ profun-op+)
   (* profun-op*)
   (sqrt profun-op-sqrt)
   (< profun-op-less)
   (divisible profun-op-divisible)
   (equals profun-op-equals)
   ))

(define definitions1
  `(((person "bart"))
    ((person "lisa"))
    ((person "maggie"))
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
        (define question (list-ref sentences 0))
        (define expected (list-ref sentences 1))
        (define actual (profune-communicator-handle comm question))
        (unless (equal? expected actual)
          (debugv expected)
          (debugv actual))
        (assert= expected actual)
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
 '((whats (sqrt X Y))
   (whats (value (or X Y)))
   (whats (sqrt 9 Z))
   (its (equals (((Z . 3)))))
   (its (equals (((Y . 4)))))
   (its (equals (((Y . 4) (X . 16)))))
   ))

(test-dialog
 '((whats (sqrt X Y))
   (whats (value (or X Y)))
   (whats (sqrt W Z))
   (whats (value (or W Z)))
   (its (equals (((W . 16)))))
   (its (equals (((W . 16) (Z . 4)))))
   (its (= X 9))
   (its (equals (((Y . 3) (X . 9)))))
   ))

(test-dialog
 '((whats (swrt 9 Y))
   (i-dont-recognize swrt 2)
   (whats (sqrt 9 Y))
   (its (equals (((Y . 3)))))
   ))

(test-dialog
 '((whats (person X))
   (its (equals (((X . "bart")))))
   (more (2))
   (its (equals (((X . "lisa")) ((X . "maggie")))))
   (more (100))
   (its (equals (((X . "homer")) ((X . "marge")))))
   (more (50))
   (its (equals ()))
   (more (40))
   (its (equals ()))
   ))

(test-dialog
 '((whats (person X) more (2))
   (its (equals (((X . "bart")) ((X . "lisa")) ((X . "maggie")))))
   (more (100))
   (its (equals (((X . "homer")) ((X . "marge")))))
   (more (50))
   (its (equals ()))
   (more (40))
   (its (equals ()))
   ))
