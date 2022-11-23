
%run guile

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
%use (profune-communications) "./src/profune-communications.scm"
%use (make-profune-communicator) "./src/profune-communicator.scm"

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

(define comms1
  (profune-communications client-comm server-comm))


