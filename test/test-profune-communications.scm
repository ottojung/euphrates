
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (debug) "./src/debug.scm"
%use (debugv) "./src/debugv.scm"
%use (lines->string) "./src/lines-to-string.scm"
%use (printf) "./src/printf.scm"
%use (profun-set) "./src/profun-accept.scm"
%use (profun-answer-join/and profun-answer-join/any profun-answer-join/or) "./src/profun-answer-join.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-op-divisible) "./src/profun-op-divisible.scm"
%use (profun-op-equals) "./src/profun-op-equals.scm"
%use (profun-op-false) "./src/profun-op-false.scm"
%use (profun-op-lambda) "./src/profun-op-lambda.scm"
%use (profun-op-less) "./src/profun-op-less.scm"
%use (profun-op*) "./src/profun-op-mult.scm"
%use (profun-op+) "./src/profun-op-plus.scm"
%use (profun-op-separate) "./src/profun-op-separate.scm"
%use (profun-op-sqrt) "./src/profun-op-sqrt.scm"
%use (profun-op-true) "./src/profun-op-true.scm"
%use (profun-op-unify) "./src/profun-op-unify.scm"
%use (profun-reject) "./src/profun-reject.scm"
%use (profun-create-database) "./src/profun.scm"
%use (profune-communications-hook/p) "./src/profune-communications-hook-p.scm"
%use (profune-communications) "./src/profune-communications.scm"
%use (make-profune-communicator) "./src/profune-communicator.scm"
%use (raisu) "./src/raisu.scm"
%use (~a) "./src/tilda-a.scm"
%use (words->string) "./src/words-to-string.scm"

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
   (value
    (profun-op-lambda
     (ctx (x) (x-name))
     (let loop ((x x))
       (cond
        ((symbol? x)
         (case x
           ((X) (profun-set ('X <- 9)))
           ((Y) (profun-set ('Y <- 16)))
           (else (profun-reject))))
        ((and (pair? x)
              (list? (cdr x)))
         (let ((composer
                (case (car x)
                  ((any) profun-answer-join/any)
                  ((or) profun-answer-join/or)
                  ((and) profun-answer-join/and)
                  (else (raisu 'uknown-value-composer (car x))))))
           (let lp2 ((buf (cdr x))
                     (ret (profun-reject)))
             (if (null? buf) ret
                 (let* ((u (car buf))
                        (y (loop u)))
                   (lp2 (cdr buf) (composer ret y)))))))
        (else
         (raisu 'uknown-value-format x))))))
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
               "[server] its (equals (((X . bart))))"
               "result = (((X . bart)))"
               )

  (test-dialog '(whats (person X))
               "[client] whats (person X)"
               "[server] its (equals (((X . bart))))"
               "result = (((X . bart)))"
               )

  (test-dialog '(whats (sqrt X Y))
               "[client] whats (sqrt X Y)"
               "[server] whats (value (any X Y))"
               "[client] its (equals (((X . 9))))"
               "[server] its (equals (((Y . 3) (X . 9))))"
               "result = (((Y . 3) (X . 9)))"
               )

  )
