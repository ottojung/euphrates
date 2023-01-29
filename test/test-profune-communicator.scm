
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (debugv) "./euphrates/debugv.scm"
%use (profun-make-handler) "./euphrates/profun-handler.scm"
%use (profun-op-divisible) "./euphrates/profun-op-divisible.scm"
%use (profun-op-equals) "./euphrates/profun-op-equals.scm"
%use (profun-op-false) "./euphrates/profun-op-false.scm"
%use (profun-op-less) "./euphrates/profun-op-less.scm"
%use (profun-op*) "./euphrates/profun-op-mult.scm"
%use (profun-op+) "./euphrates/profun-op-plus.scm"
%use (profun-op-separate) "./euphrates/profun-op-separate.scm"
%use (profun-op-sqrt) "./euphrates/profun-op-sqrt.scm"
%use (profun-op-true) "./euphrates/profun-op-true.scm"
%use (profun-op-unify) "./euphrates/profun-op-unify.scm"
%use (profun-create-database) "./euphrates/profun.scm"
%use (make-profune-communicator profune-communicator-handle) "./euphrates/profune-communicator.scm"
%use (raisu) "./euphrates/raisu.scm"

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
   (its (= Y 3))
   ))

(test-dialog
 '((whats (= X 9) (sqrt X Y))
   (its (= Y 3) (= X 9))
   ))

(test-dialog
 '((more)
   (error (nothing-to-show use-a-whats-first))
   ))

(test-dialog
 '((whats (= X 9) (sqrt X Y) more (2))
   (its (equals (((Y . 3) (X . 9)))))
   ))

(test-dialog
 '((whats (= X 9) (sqrt X Y))
   (its (= Y 3) (= X 9))
   (whats (= Y 4) (sqrt X Y))
   (its (= Y 4) (= X 16))
   ))

(test-dialog
 '((whats (sqrt X Y))
   (whats (value (any X Y)))
   (its (= X 9))
   (its (= Y 3) (= X 9))
   ))

(test-dialog
 '((whats (sqrt 9 3))
   (its (true))
   ))

(test-dialog
 '((whats (sqrt 9 3) more (1))
   (its (equals (())))
   ))

(test-dialog
 '((whats (= X 10) (sqrt X Y))
   (its (false))
   ))

(test-dialog
 '((whats (= X 10) (sqrt X Y) more (1))
   (its (equals ()))
   ))

(test-dialog
 '((whats (= K 1) (sqrt X Y))
   (whats (value (any X Y)))
   (whats (= K I))
   (whats (value (any K I)))
   ))

(test-dialog
 '((whats (sqrt X Y))
   (whats (value (any X Y)))
   (whats (sqrt 9 Z))
   (its (= Z 3))
   (its (= Y 4))
   (its (= Y 4) (= X 16))
   ))

(test-dialog
 '((whats (sqrt X Y))
   (whats (value (any X Y)))
   (whats (sqrt W Z))
   (whats (value (any W Z)))
   (its (= W 16))
   (its (= W 16) (= Z 4))
   (its (= X 9))
   (its (= Y 3) (= X 9))
   ))

(test-dialog
 '((whats (swrt 9 Y))
   (i-dont-recognize swrt 2)
   (whats (sqrt 9 Y))
   (its (= Y 3))
   ))

(test-dialog
 '((whats (= X 9) (sqrt Z Y))
   (whats (value (any Z Y)))
   (inspect whats (+ 1 M X))
   (its (= X 9) (= M 8))
   ))

(test-dialog
 '((whats (sqrt M Y) more (2))
   (whats (value (any M Y)))
   (its (< M 17))
   (its (equals (((Y . 4) (M . 16)) ((Y . 3) (M . 9)) ((Y . 2) (M . 4)))))
   ))

(test-dialog
 '((whats (person X))
   (its (= X "bart"))
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

(test-dialog
 '((nonexisting x y z)
   (error (operation-not-supported nonexisting))
   ))

(test-dialog
 '((whats (person X) nonexisting x y z)
   (error (unexpected-operation nonexisting))
   ))

(test-dialog
 '((its ok)
   (error (did-not-ask-anything))
   ))

(test-dialog
 '((whats (= 0 1))
   (its (false))
   (its ok)
   (error (did-not-ask-anything))
   ))

(test-dialog
 '((whats (= 0 1))
   (its (false))
   (its ok)
   (error (did-not-ask-anything))
   (whats (= X 3))
   (its (= X 3))
   ))

(test-dialog
 '((whats (sqrt X Y))
   (whats (value (any X Y)))
   (whats (sqrt W Z))
   (whats (value (any W Z)))
   (its (equals (((W . 16)))))
   (its (= W 16) (= Z 4))
   (nonexisting x y z)
   (error (operation-not-supported nonexisting))
   (its (= X 9))
   (its (= Y 3) (= X 9))
   ))

(test-dialog
 '((whats (= X 4) (< Y X))
   (its (= Y 3) (= X 4))
   (more)
   (its (= Y 2) (= X 4))
   (inspect whats (+ X Y Z))
   (its (= Y 2) (= X 4) (= Z 6))
   ))

(test-dialog
 '((whats (= X 4) (+ X X Y))
   (its (= Y 8) (= X 4))
   (inspect whats (+ X Y Z))
   (its (= Y 8) (= X 4) (= Z 12))
   ))

(test-dialog
 '((whats (= X 4) (< Y X))
   (its (= Y 3) (= X 4))
   (more)
   (its (= Y 2) (= X 4))
   (inspect whats (< Z Y))
   (its (= Y 2) (= X 4) (= Z 1))
   (more)
   (its (= Y 2) (= X 4) (= Z 0))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (more)
   (its (= Y 7) (= X 9))
   (inspect whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (more)
   (its (= Y 7) (= X 9) (= Z 5))
   (return)
   (ok)
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (more)
   (its (= Y 7) (= X 9))
   (inspect)
   (ok)
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (more)
   (its (= Y 7) (= X 9) (= Z 5))
   (return)
   (ok)
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (inspect whats (< Z Y))
   (its (= Y 8) (= X 9) (= Z 7))
   (return)
   (ok)
   (more)
   (its (= Y 7) (= X 9))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (more)
   (its (= Y 7) (= X 9))
   (inspect whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (more)
   (its (= Y 7) (= X 9) (= Z 5))
   (return)
   (ok)
   (more)
   (its (= Y 6) (= X 9))
   (more)
   (its (= Y 5) (= X 9))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (more)
   (its (= Y 7) (= X 9))
   (inspect)
   (ok)
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (more)
   (its (= Y 7) (= X 9) (= Z 5))
   (return)
   (ok)
   (more)
   (its (= Y 6) (= X 9))
   (return)
   (ok)
   (more)
   (error (nothing-to-show use-a-whats-first))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (more)
   (its (= Y 7) (= X 9))
   (inspect)
   (ok)
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (more)
   (its (= Y 7) (= X 9) (= Z 5))
   (return)
   (ok)
   (more)
   (its (= Y 6) (= X 9))
   (inspect whats (< Z Y))
   (its (= Y 6) (= X 9) (= Z 5))
   (return)
   (ok)
   (more)
   (its (= Y 5) (= X 9))
   (return)
   (ok)
   (more)
   (error (nothing-to-show use-a-whats-first))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (more)
   (its (= Y 7) (= X 9))
   (inspect)
   (ok)
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (whats (< Z Y))
   (its (= Y 7) (= X 9) (= Z 6))
   (more)
   (its (= Y 7) (= X 9) (= Z 5))
   (return)
   (ok)
   (more)
   (its (= Y 6) (= X 9))
   (inspect whats (< Z Y))
   (its (= Y 6) (= X 9) (= Z 5))
   (return return)
   (ok)
   (more)
   (error (nothing-to-show use-a-whats-first))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (inspect whats (< Z Y))
   (its (= Y 8) (= X 9) (= Z 7))
   (return)
   (ok)
   (return)
   (ok)
   (return)
   (error (nowhere to return))
   ))

(test-dialog
 '((whats (= X 9) (< Y X))
   (its (= Y 8) (= X 9))
   (inspect whats (= Z X))
   (its (= Y 8) (= X 9) (= Z 9))
   ))

(test-dialog
 '((whats (= _X 9) (< Y _X))
   (its (= Y 8))
   (inspect whats (= Z _X))
   (its (= Y 8) (= Z 9))
   ))

(test-dialog
 '((whats (= _X 9) (< Y _X))
   (its (= Y 8))
   (reset)
   (ok)
   (inspect whats (= Z _X))
   (error (nothing-to-inspect use-a-whats-first))
   ))

(test-dialog
 '((whats (= _X 9) (< Y _X))
   (its (= Y 8))
   (reset)
   (ok)
   (inspect whats (= Z _X))
   (error (nothing-to-inspect use-a-whats-first))
   (whats (= _X 9) (< Y _X))
   (its (= Y 8))
   (inspect whats (= Z _X))
   (its (= Y 8) (= Z 9))
   ))

(test-dialog
 '((listen
    ((fav1 X) (= X 2))
    ((fav1 X) (= X 3))
    ((fav1 X) (= X 7))
    whats
    (fav1 Y))
   (its (= Y 2))
   ))

(test-dialog
 '((listen
    (1 2 3 4)
    (5 6)
    whats
    (fav2 Y))
   (error (rule-has-a-bad-type "It should be a list of lists, but is not" (1 2 3 4)))
   ))

(test-dialog
 '((listen
    ((fav2 X) (= X 3))
    ((0 X) (= X 2))
    ((fav2 X) (= X 7))
    whats
    (fav2 Y))
   (error (rule-has-non-list-clauses "All rule clauses should be symbols, but some are not" (0) ((0 X) (= X 2))))
   ))

(test-dialog
 '((listen
    (((fav3 X) (= X 2))
     ((fav3 X) (= X 3))
     ((fav3 X) (= X 7)))
    whats
    (fav3 Y))
   (error (rule-has-non-list-clauses "All rule clauses should be symbols, but some are not" ((fav3 X) (fav3 X) (fav3 X)) (((fav3 X) (= X 2)) ((fav3 X) (= X 3)) ((fav3 X) (= X 7)))))
   ))

(test-dialog
 '((listen
    ((fav4 X) (bad-name X K))
    ((fav4 X) (= X 3))
    whats
    (= Y 2))
   (error (rule-uses-undefined-predicates "Rule uses names that are not present in the database, this is not allowed" ((bad-name . 2)) ((fav4 X) (bad-name X K))))
   ))

(test-dialog
 '((listen
    ((fav4 X) (fav4 X))
    ((fav4 X) (= X 3))
    whats
    (= Y 2))
   (error (rule-uses-undefined-predicates "Rule uses names that are not present in the database, this is not allowed" ((fav4 . 1)) ((fav4 X) (fav4 X))))
   ))
