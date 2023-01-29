
%run guile

%use (assert=) "./euphrates/assert-equal.scm"
%use (lines->string) "./euphrates/lines-to-string.scm"
%use (printf) "./euphrates/printf.scm"
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
%use (profun-op-value) "./euphrates/profun-op-value.scm"
%use (profun-create-database) "./euphrates/profun.scm"
%use (profune-communications-hook/p) "./euphrates/profune-communications-hook-p.scm"
%use (profune-communications) "./euphrates/profune-communications.scm"
%use (make-profune-communicator) "./euphrates/profune-communicator.scm"
%use (~a) "./euphrates/tilda-a.scm"
%use (words->string) "./euphrates/words-to-string.scm"

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

(define client-handler
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
   (value (profun-op-value '((M (< M 17))) '((X . 9) (Y . 16))))
   ))

(define definitions1
  `(((person "bart"))
    ((person "lisa"))
    ((person "maggie"))
    ((person "homer"))
    ((person "marge"))))

(define client-db
  (profun-create-database client-handler definitions1))

(define server-db
  (profun-create-database server-handler definitions1))

(define client-comm
  (make-profune-communicator client-db))

(define server-comm
  (make-profune-communicator server-db))

(parameterize ((profune-communications-hook/p
                (lambda (recepient args)
                  (printf "[~s] ~a\n" recepient
                          (words->string (map ~a args))))))

  (define comms1
    (profune-communications client-comm server-comm))

  (define (test-dialog input . lines)
    (define expected (lines->string lines))
    (define actual
      (with-output-to-string
        (lambda _
          (define result (comms1 input))
          (printf "result = ~a" result))))
    (unless (equal? expected actual)
      (parameterize ((current-output-port (current-error-port)))
        (printf "expected:\n~a\n" expected)
        (printf "actual:\n~a\n" actual)))
    (assert= expected actual))

  (test-dialog '(whats (person X))
               "[client] whats (person X)"
               "[server] its (= X bart)"
               "result = (((X . bart)))"
               )

  (test-dialog '(whats (person X))
               "[client] whats (person X)"
               "[server] its (= X bart)"
               "result = (((X . bart)))"
               )

  (test-dialog '(whats (sqrt X Y))
               "[client] whats (sqrt X Y)"
               "[server] whats (value (any X Y))"
               "[client] its (= X 9)"
               "[server] its (= Y 3) (= X 9)"
               "result = (((Y . 3) (X . 9)))"
               )

  (test-dialog '(whats (sqrt M Y))
               "[client] whats (sqrt M Y)"
               "[server] whats (value (any M Y))"
               "[client] its (< M 17)"
               "[server] its (= Y 4) (= M 16)"
               "result = (((Y . 4) (M . 16)))"
               )

  (test-dialog '(whats (sqrt M Y) more (2))
               "[client] whats (sqrt M Y) more (2)"
               "[server] whats (value (any M Y))"
               "[client] its (< M 17)"
               "[server] its (equals (((Y . 4) (M . 16)) ((Y . 3) (M . 9)) ((Y . 2) (M . 4))))"
               "result = (((Y . 4) (M . 16)) ((Y . 3) (M . 9)) ((Y . 2) (M . 4)))"
               )

  )
