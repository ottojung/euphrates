
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (bool->profun-result) "./src/bool-to-profun-result.scm"
%use (debugs) "./src/debugs.scm"
%use (debugv) "./src/debugv.scm"
%use (make-profun-RFC) "./src/profun-RFC.scm"
%use (profun-set) "./src/profun-accept.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-op-false) "./src/profun-op-false.scm"
%use (profun-op-lambda) "./src/profun-op-lambda.scm"
%use (profun-op-less) "./src/profun-op-less.scm"
%use (profun-op*) "./src/profun-op-mult.scm"
%use (profun-op+) "./src/profun-op-plus.scm"
%use (profun-op-separate) "./src/profun-op-separate.scm"
%use (profun-op-true) "./src/profun-op-true.scm"
%use (profun-op-unify) "./src/profun-op-unify.scm"
%use (profun-unbound-value?) "./src/profun-value.scm"
%use (profun-create-database) "./src/profun.scm"
%use (make-profune-communicator) "./src/profune-communications.scm"

(define server-handler
  (profun-make-handler
   (= profun-op-unify)
   (true profun-op-true)
   (false profun-op-false)
   (!= profun-op-separate)
   (+ profun-op+)
   (* profun-op*)
   (< profun-op-less)
   (sqrt
    (profun-op-lambda
     (ctx (x y) (x-name y-name))
     (debugs x-name)
     (debugs y-name)
     (cond
      ((and (profun-unbound-value? x)
            (profun-unbound-value? y))
       (make-profun-RFC #f `((value (or ,x-name ,y-name)))))
      ((profun-unbound-value? x)
       (profun-set
        (x-name <- (* y y))))
      ((profun-unbound-value? y)
       (profun-set
        (y-name <- (sqrt x))))
      (else
       (bool->profun-result
        (equal? x (* y y)))))))
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
  (define server-comm1
    (make-profune-communicator db1))

  (define got1
    (server-comm1 '(whats (person X))))

  (assert= got1 `(its (equals (((X . "bart"))))))

  (define got2
    (server-comm1 '(more (2))))

  (assert= got2 `(its (equals (((X . "lisa")) ((X . "megie"))))))

  (define got3
    (server-comm1 '(more (100))))

  (assert= got3 `(its (equals (((X . "homer")) ((X . "marge"))))))

  (define got4
    (server-comm1 '(more (50))))

  (assert= got4 `(its (equals ())))

  )

(let ()
  (define server-comm1
    (make-profune-communicator db1))

  (define got1
    (server-comm1 '(whats (person X) more (2))))

  (assert= got1 `(its (equals (((X . "bart")) ((X . "lisa")) ((X . "megie"))))))

  (define got2
    (server-comm1 '(more (100))))

  (assert= got2 `(its (equals (((X . "homer")) ((X . "marge"))))))

  (define got3
    (server-comm1 '(more (50))))

  (assert= got3 `(its (equals ())))

  )

(let ()
  (define server-comm1
    (make-profune-communicator db1))

  ;; (define got1
  ;;   (server-comm1 '(whats (sqrt X 3) more (2))))

  ;; (define got1
  ;;   (server-comm1 '(whats (sqrt 9 Y) more (2))))

  ;; (define got1
  ;;   (server-comm1 '(whats (sqrt 9 3) more (2))))

  (define got1
    (server-comm1 '(whats (sqrt X Y) more (2))))

  (debugv got1)

  (define got2
    (server-comm1 '(its (= X 9))))

  (debugv got2)

  )


