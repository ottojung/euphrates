
(cond-expand
 (guile
  (define-module (test-profun)
    :use-module ((euphrates assert-equal) :select (assert=))
    :use-module ((euphrates assert) :select (assert))
    :use-module ((euphrates catchu-case) :select (catchu-case))
    :use-module ((euphrates debug) :select (debug))
    :use-module ((euphrates printf) :select (printf))
    :use-module ((euphrates profun-RFC) :select (profun-RFC-insert profun-RFC-what profun-RFC?))
    :use-module ((euphrates profun-accept) :select (profun-accept))
    :use-module ((euphrates profun-error) :select (profun-error-args profun-error?))
    :use-module ((euphrates profun-handler) :select (profun-handler-extend))
    :use-module ((euphrates profun-make-set) :select (profun-make-set))
    :use-module ((euphrates profun-make-tuple-set) :select (profun-make-tuple-set))
    :use-module ((euphrates profun-op-apply) :select (profun-apply-fail! profun-apply-return! profun-op-apply))
    :use-module ((euphrates profun-op-envlambda) :select (profun-op-envlambda))
    :use-module ((euphrates profun-op-eval) :select (profun-eval-fail! profun-op-eval))
    :use-module ((euphrates profun-op-function) :select (profun-op-function))
    :use-module ((euphrates profun-op-parameter) :select (instantiate-profun-parameter make-profun-parameter))
    :use-module ((euphrates profun-op-value) :select (profun-op-value))
    :use-module ((euphrates profun-reject) :select (profun-reject))
    :use-module ((euphrates profun-standard-handler) :select (profun-standard-handler))
    :use-module ((euphrates profun) :select (profun-create-database profun-eval-query profun-iterate profun-next)))))

;; profun

(define current-handler
  (make-parameter #f))

(define current-definitions
  (make-parameter #f))

(define (get-db)
  (define handler (current-handler))
  (define definitions (current-definitions))
  (profun-create-database handler definitions))

(define (get-iter query)
  (define db (get-db))
  (profun-iterate db query))

(define (run-query query)
  (define db (get-db))
  (profun-eval-query db query))

(cond-expand
 (guile
  (use-modules (ice-9 pretty-print))))

(define (pretty x)
  (cond-expand
   (guile
    (pretty-print x))
   (else
    (write x))))

(define (test query expected-result)
  (define result (run-query query))
  (unless (equal? expected-result result)
    (debug "expected:")
    (pretty expected-result)
    (debug "actual:")
    (pretty result))
  (assert= expected-result result))

(define-syntax test-rfc
  (syntax-rules ()
    ((_ query expected-what)
     (let ((threw? #f)
           (actual-what #f))
       (catchu-case
        (run-query query)
        (('profun-needs-more-info rfc)
         (set! actual-what (profun-RFC-what rfc))
         (set! threw? #t)))
       (assert threw?)
       (unless (equal? expected-what actual-what)
         (debug "expected:")
         (pretty expected-what)
         (debug "actual:")
         (pretty actual-what))
       (assert= expected-what actual-what)))))

(define-syntax test-cr
  (syntax-rules ()
    ((_ query expected-what)
     (let ((threw? #f)
           (actual-what #f))
       (catchu-case
        (run-query query)
        (('profun-returned-custom-value cr)
         (set! actual-what cr)
         (set! threw? #t)))
       (assert threw?)
       (unless (equal? expected-what actual-what)
         (debug "expected:")
         (pretty expected-what)
         (debug "actual:")
         (pretty actual-what))
       (assert= expected-what actual-what)))))

(define-syntax test-error
  (syntax-rules ()
    ((_ query expected-what)
     (let ((threw? #f)
           (actual-what #f))
       (catchu-case
        (run-query query)
        (('profun-errored error)
         (set! actual-what error)
         (set! threw? #t)))
       (assert threw?)
       (unless (equal? expected-what actual-what)
         (debug "expected:")
         (pretty expected-what)
         (debug "actual:")
         (pretty actual-what))
       (assert= expected-what actual-what)))))

(define-syntax test-definitions
  (syntax-rules ()
    ((_ title definitions . body)
     (parameterize ((current-definitions definitions))

       (test '((= 1 0)) '())
       (test '((= 1 1)) '(()))
       (test '((bad-op 1 2 3)) '())
       (test '((= 1 2 3)) '()) ;; bad arity

       (let () . body)))))

  ;;;;;;;;;;;
;; TESTS ;;
  ;;;;;;;;;;;

(define param1
  (make-profun-parameter))
(define param1-printer
  (profun-op-envlambda
   (ctx env args-names)
   (assert (procedure? env))
   (printf "param1 = ~s\n" (param1))
   (profun-accept)))

(define functional-addition
  (profun-op-function 2 +))

(define functional-division
  (profun-op-function
   (2 2)
   (lambda (x y)
     (if (= 0 y)
         (profun-reject)
         (values (quotient x y)
                 (remainder x y))))))

(define default-handler
  (profun-handler-extend
   profun-standard-handler

   (value (profun-op-value '((M (< M 17))) '((X . 9) (Y . 16))))

   (apply profun-op-apply)
   (eval profun-op-eval)

   (favorite (profun-make-set (list 777 2 9 3)))
   (favorite2 (profun-make-tuple-set (a b) '((777 2) (#t 9) (3 #f))))

   (p1 (instantiate-profun-parameter param1))
   (printp1 param1-printer)

   (fadd functional-addition)
   (fdiv functional-division)
   ))

(parameterize ((current-handler default-handler))

  (test-definitions
   "SIMPLE REJECTING"
   '(((abc x y) (= x 3) (= x y) (= y 4)))

   (test '((abc 2 3)) '())
   (test '((abc "hello" "bye")) '())
   (test '((abc a b)) '())
   )

  (test-definitions
   "SIMPLE ACCEPTING"
   '(((abc z k) (= 1 1)))

   (test '((abc 2 3)) '(()))
   (test '((abc "hello" "bye")) '(()))
   (test '((abc a b)) '(()))
   )

  (test-definitions
   "MULTIPLE ACCEPTING"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (test '((abc x)) '(((x . 1)) ((x . 2)) ((x . 3))))
   )

  (test-definitions
   "NO DATABASE"
   '()

   (test '((abc 2 3)) '())
   (test '((abc "hello" "bye")) '())
   (test '((abc a b)) '())
   )

  (test-definitions
   "COMPLEX DEFINITIONS"
   '(((abc z k) (= z 8) (= p 10))
     ((yyy x) (abc x))
     ((abc x y) (= x 3) (= x y) (= y 3))
     ((abc x y) (= x "kek") (= y 5))
     ((abc z k) (= z 8) (= k 9)))

   (test '((abc 2 3)) '())
   (test '((abc "hello" "bye")) '())
   (test '((abc x y))
         '(((x . 8)) ((x . 3) (y . 3)) ((x . "kek") (y . 5)) ((x . 8) (y . 9))))
   )

  (test-definitions
   "SIMPLE SUGAR"
   '(((abc 8 y) (= y 10)))

   (test '((abc 2 3)) '())
   (test '((abc "hello" "bye")) '())
   (test '((abc a b)) '(((a . 8) (b . 10))))
   (test '((abc 8 b)) '(((b . 10))))
   (test '((abc 8 10)) '(()))
   (test '((abc a 10)) '(((a . 8))))
   )

  (test-definitions
   "ALL ACCEPTING WITH A SPECIAL CASE"
   '(((start k u) (abc k u))
     ((abc 8 y) (= y 10))
     ((abc x y)))

   (test '((start 2 3)) '(()))
   (test '((start "hello" "bye")) '(()))
   (test '((start a b)) '(((a . 8) (b . 10)) ()))
   (test '((start 8 b)) '(((b . 10)) ()))
   (test '((start 8 10)) '(() ()))
   (test '((start a 10)) '(((a . 8)) ()))
   )

  (test-definitions
   "ALL ACCEPTING WITH A SPECIAL CASE 2"
   '(((start k u) (abc k u))
     ((abc 8 y) (= y 10))
     ((abc x y) (= 1 1)))

   (test '((start 2 3)) '(()))
   (test '((start "hello" "bye")) '(()))
   (test '((start a b)) '(((a . 8) (b . 10)) ()))
   (test '((start 8 b)) '(((b . 10)) ()))
   (test '((start 8 10)) '(() ()))
   (test '((start a 10)) '(((a . 8)) ()))
   )

  (test-definitions
   "NOT EQUAL 1"
   '(((abc 8 y) (= k 10) (= y 3) (!= y k)))

   (test '((abc 2 3)) '())
   (test '((abc "hello" "bye")) '())
   (test '((abc a b)) '(((a . 8) (b . 3))))
   )

  (test-definitions
   "NOT EQUAL 2"
   '(((abc k y) (= y 3) (!= y k)))

   (test '((abc 2 3)) '(()))
   (test '((abc 2 8)) '())
   (test '((abc 8 8)) '())
   (test '((abc 3 3)) '())
   (test '((abc "hello" "bye")) '())
   )

  (test-definitions
   "NO ARGUMENTS QUERY 1"
   '(((foo) (= 1 0)))

   (test '((foo)) '())
   )

  (test-definitions
   "NO ARGUMENTS QUERY 2"
   '(((foo) (= 1 1)))

   (test '((foo)) '(()))
   )

  (test-definitions
   "NO ARGUMENTS QUERY 3"
   '(((foo) (= 1 0))
     ((foo) (= 1 1)))

   (test '((foo)) '(()))
   )

  (test-definitions
   "UNIQUENESS"
   '(((foo 1))
     ((foo 2)))

   (test '((foo x) (foo y) (!= x y)) '(((x . 1) (y . 2)) ((x . 2) (y . 1))))
   )

  (test-definitions
   "TRUTH"
   '()

   (test '((true)) '(()))
   )

  (test-definitions
   "LIE"
   '()

   (test '((false)) '())
   )

  (test-definitions
   "EMPTY QUERY"
   '(((start k u) (abc k u))
     ((abc 8 y) (= y 10))
     ((abc x y) (= 1 1)))

   (test '() '(()))
   )

  (test-definitions
   "+ CASES"
   '()

   (test '((+ 2 3 5)) '(()))
   (test '((+ 2 3 1)) '())
   (test '((+ 2 1 5)) '())
   (test '((+ 1 3 5)) '())

   (test '((+ 2 3 z)) '(((z . 5))))
   (test '((+ 2 y 5)) '(((y . 3))))
   (test '((+ x 3 5)) '(((x . 2))))

   (test '((+ x x 16)) '(((x . 8))))
   (test '((+ x x 7)) '())
   (test '((+ x x 8)) '(((x . 4))))
   (test '((+ x x 9)) '())

   (test-rfc '((+ x 0 x)) '((value x)))
   (test-rfc '((+ 0 y y)) '((value y)))
   (test '((+ z 1 z)) '())
   (test '((+ 2 z z)) '())
   (test '((+ z 3 z)) '())
   (test '((+ 4 z z)) '())

   )

  (test-definitions
   "* CASES"
   '()

   (test '((* 2 3 6)) '(()))
   (test '((* 2 3 1)) '())
   (test '((* 2 1 5)) '())
   (test '((* 1 3 5)) '())

   (test '((* 2 3 z)) '(((z . 6))))
   (test '((* 2 y 6)) '(((y . 3))))
   (test '((* x 3 6)) '(((x . 2))))

   (test '((* 0 3 z)) '(((z . 0))))
   (test '((* 0 y 6)) '())
   (test '((* x 3 6)) '(((x . 2))))

   (test '((* x x 16)) '(((x . 4))))
   (test '((* x x 7)) '())
   (test '((* x x 8)) '())
   (test '((* x x 9)) '(((x . 3))))

   (test-rfc '((* x 1 x)) '((value x)))
   (test-rfc '((* 1 y y)) '((value y)))
   (test '((* 2 z z)) '())
   (test '((* z 3 z)) '())
   (test '((* 4 z z)) '())
   (test '((* 0 z z)) '(((z . 0))))
   (test '((* z 0 z)) '(((z . 0))))

   )

  (test-definitions
   "modulo CASES"
   '()

   (test '((modulo 6 3 2 0)) '(()))
   (test '((modulo 6 3 2 r)) '(((r . 0))))
   (test '((modulo 6 3 q 0)) '(((q . 2))))
   (test '((modulo 6 3 q r)) '(((q . 2) (r . 0))))
   (test '((modulo x 3 2 0)) '(((x . 6))))
   (test '((modulo 6 y 2 0)) '(((y . 3))))

   (test '((modulo 9 4 2 1)) '(()))
   (test '((modulo 9 4 2 r)) '(((r . 1))))
   (test '((modulo 9 4 q 1)) '(((q . 2))))
   (test '((modulo 9 4 q r)) '(((q . 2) (r . 1))))
   (test '((modulo x 4 2 1)) '(((x . 9))))
   (test '((modulo 9 y 2 1)) '(((y . 4))))

   (test '((modulo 777 23 33 18)) '(()))
   (test '((modulo 777 23 33 r)) '(((r . 18))))
   (test '((modulo 777 23 q 18)) '(((q . 33))))
   (test '((modulo 777 23 q r)) '(((q . 33) (r . 18))))
   (test '((modulo x 23 33 18)) '(((x . 777))))
   (test '((modulo 777 y 33 18)) '(((y . 23))))

   (test '((modulo x x 2 1)) '())
   (test '((modulo x x 2 0)) '(((x . 0))))
   (test-rfc '((modulo x x 1 0)) '((value x)))
   (test-rfc '((modulo x x 1 r)) '((value (any x r))))
   (test-rfc '((modulo x x q 0)) '((value (any x q))))

   (test '((modulo x 1 x 2)) '())
   (test-rfc '((modulo x y x r)) '((value x)))
   (test-rfc '((modulo x 1 x 0)) '((value x)))

   (test '((modulo x 0 0 x)) '(()))
   (test '((modulo x 1 1 x)) '())
   (test '((modulo x y q x)) '(((q . 0) (y . 0))))

   (test '((modulo 5 y y 1)) '(((y . 2))))
   (test '((modulo 7 y y 2)) '())
   (test '((modulo 10 y y 1)) '(((y . 3))))
   (test '((modulo 9 y y 1)) '())

   (test '((modulo 5 y 2 y)) '())
   (test-rfc '((modulo x y q y)) '((value y)))

   (test '((modulo 3 7 0 3)) '())
   (test '((modulo 3 7 q r)) '())

   )

  (test-definitions
   "SQRT CASES"
   '()

   (test '((sqrt 9 3)) '(()))
   (test '((sqrt 10 3)) '())
   (test '((sqrt 0 3)) '())
   (test '((sqrt 1 3)) '())

   (test '((sqrt 9 y)) '(((y . 3))))
   (test '((sqrt x 3)) '(((x . 9))))
   )

  (test-definitions
   "< CASES"
   '()

   (test '((< 2 3)) '(()))
   (test '((< 2 2)) '())
   (test '((< 2 1)) '())

   (test '((< x 4)) '(((x . 3)) ((x . 2)) ((x . 1)) ((x . 0))))
   (test '((< x 4) (* 2 x a)) '(((a . 6) (x . 3))
                                ((a . 4) (x . 2))
                                ((a . 2) (x . 1))
                                ((a . 0) (x . 0))))
   (test '((= 1 y) (< x y)) '(((x . 0) (y . 1))))
   (test '((< y 4) (< x y)) '(((x . 2) (y . 3))
                              ((x . 1) (y . 3))
                              ((x . 0) (y . 3))
                              ((x . 1) (y . 2))
                              ((x . 0) (y . 2))
                              ((x . 0) (y . 1))))

   )

  (test-definitions
   "divisible CASES"
   '()

   (test '((divisible 10 4)) '())
   (test '((divisible 10 5)) '(()))
   (test '((divisible 10 x)) '(((x . 1)) ((x . 2)) ((x . 5)) ((x . 10))))
   (test '((divisible 12 x)) '(((x . 1)) ((x . 2)) ((x . 3)) ((x . 4)) ((x . 6)) ((x . 12))))
   (test '((< x 12) (divisible 12 x)) '(((x . 6)) ((x . 4)) ((x . 3)) ((x . 2)) ((x . 1))))
   )

  (test-definitions
   "equals CASES"
   '()

   (test '((equals (((X . 1))))) '(((X . 1))))
   (test '((equals (((Y . 2) (X . 1))))) '(((Y . 2) (X . 1))))
   (test '((equals (((Y . 2) (X . 1))
                    ((Y . 3) (X . 4)))))
         '(((Y . 2) (X . 1))
           ((Y . 3) (X . 4))))
   (test '((equals (((Y . 2) (X . 1))
                    ((Y . 3) (X . 4))
                    ((Y . 5) (X . 6))
                    )))
         '(((Y . 2) (X . 1))
           ((Y . 3) (X . 4))
           ((Y . 5) (X . 6))
           ))
   )

  (test-definitions
   "value CASES"
   '()

   (test '((value X)) '(((X . 9))))
   (test '((value Y)) '(((Y . 16))))
   (test '((value (any X Y Z))) '(((X . 9))))
   (test '((value (or X Y Z))) '(((Y . 16) (X . 9))))
   (test '((value (and X Y Z))) '())
   (test '((value (and X Y))) '(((Y . 16) (X . 9))))
   (test '((value (and X (or Y Z)))) '(((Y . 16) (X . 9))))
   (test '((value (and))) '(()))
   (test '((value (or))) '())
   (test '((value (any))) '())
   (test '((value (or X X))) '(((X . 9))))
   (test '((value (or X X X))) '(((X . 9))))

   (test '((= X 7) (value X)) '(((X . 7))))
   (test '((= X 7) (value (or X Y))) '(((Y . 16) (X . 7))))

   (test-cr '((value M)) `((< M 17)))
   (test-cr '((value (or M M))) `((< M 17)))
   (test-cr '((value (or M X))) `((< M 17)))
   )

  (test-definitions
   "apply CASES"
   '()

   (test `((= x 3) (apply ,(lambda (y) (profun-apply-return! 3)) x)) '(((x . 3))))
   (test `((= x 3) (apply ,(lambda (y) (profun-apply-return! 2)) x)) '())
   (test `((= x 3) (apply ,(lambda (y) (profun-apply-return! 2)) y)) '(((x . 3) (y . 2))))
   (test `((= x 3) (apply ,(lambda (y) (profun-apply-fail!)) x)) '())
   (test `((= x 3) (apply ,(lambda (y) 9) x)) '(((x . 3))))
   )

  (test-definitions
   "eval CASES"
   '()

   (test `((= x 3) (eval r ,(lambda (y) 2) x)) '(((x . 3) (r . 2))))
   (test `((= x 3) (eval r ,(lambda (y) 2) y)) '(((x . 3) (r . 2))))
   (test `((= x 3) (eval r ,(lambda (y) (profun-eval-fail!)) x)) '())
   (test `((= x 3) (eval r ,(lambda (y) 9) x)) '(((x . 3) (r . 9))))
   )

  (test-definitions
   "make-set CASES"
   '()

   (test '((favorite x)) '(((x . 777)) ((x . 2)) ((x . 9)) ((x . 3))))
   (test '((favorite 9)) '(()))
   (test '((favorite 922)) '())

   )

  (test-definitions
   "make-tuple-set CASES"
   '()

   (test '((favorite2 x y)) '(((x . 777) (y . 2)) ((y . 9)) ((x . 3))))
   (test '((favorite2 x 2)) '(((x . 777))))
   (test '((favorite2 6 9)) '(()))
   (test '((favorite2 7 9)) '(()))
   (test '((favorite2 x 9)) '(()))
   (test '((favorite2 777 y)) '(((y . 2)) ((y . 9))))
   (test '((favorite2 777 2)) '(()))
   (test '((favorite2 777 9)) '(()))
   (test '((favorite2 777 0)) '())
   (test '((favorite2 3 y)) '(((y . 9)) ()))
   (test '((favorite2 3 8)) '())
   (test '((favorite2 x y z)) '())
   (test '((favorite2 x)) '())
   )

  (test-definitions
   "TUPLE IN THE DATABASE 1"
   '(((inputs y) (= y ((("abc" "def"))))))

   (test '((inputs x)) '(((x . ((("abc" "def")))))))

   )

  (test-definitions
   "TUPLE IN THE DATABASE 2"
   '(((inputs ((("abc" "def"))))))

   (test '((inputs x)) '(((x . ((("abc" "def")))))))

   )

  (test-definitions
   "RECURSION 1"
   '(((parent "Homer" "Lisa"))
     ((parent "Homer" "Bart"))
     ((parent "Homer" "Maggie"))
     ((parent "Marge" "Lisa"))
     ((parent "Marge" "Bart"))
     ((parent "Marge" "Maggie"))
     ((parent "Abraham" "Homer"))
     ((parent "Mona" "Homer"))
     ((parent "Mr. Olsen" "Mona"))
     ((parent "Mrs. Olsen" "Mona"))
     ((parent "Bart" "Skippy"))
     ((relative x y) (parent x y))
     ((relative x y) (parent x z) (relative z y))
     )

   (test '((parent "Homer" y)) '(((y . "Lisa")) ((y . "Bart")) ((y . "Maggie"))))
   (test '((parent x "Lisa")) '(((x . "Homer")) ((x . "Marge"))))
   (test '((parent x "Lisa")) '(((x . "Homer")) ((x . "Marge"))))
   (test '((relative "Bart" y)) '(((y . "Skippy"))))
   (test '((relative "Homer" "Skippy")) '(()))
   (test '((relative "Homer" "Mona")) '())
   (test '((relative "Mr. Olsen" y)) '(((y . "Mona"))
                                       ((y . "Homer"))
                                       ((y . "Lisa"))
                                       ((y . "Bart"))
                                       ((y . "Maggie"))
                                       ((y . "Skippy"))))

   )

  (test-definitions
   "IGNORE profun-RFC IN QUERY"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (test-rfc '((= z w)) '((value (any z w))))
   )

  (test-definitions
   "IGNORE profun-RFC"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (define x
     (get-iter '((= z w))))
   (assert (profun-RFC? (profun-next x)))
   (assert= #f (profun-next x))
   (assert= #f (profun-next x))

   )

  (test-definitions
   "RERUN profun-RFC"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (define x (get-iter '((= z w))))
   (define first (profun-next x))
   (define second (profun-next x))

   (define resume-yes
     (profun-RFC-insert first '((= z 3) (= w 3))))
   (define resume-no
     (profun-RFC-insert first '((= z 3) (= w 4))))

   (assert= #f second)

   (assert= #f (profun-next resume-no))
   (assert= #f (profun-next resume-no))

   (assert= (profun-next resume-yes) '((z . 3) (w . 3)))
   (assert= #f (profun-next resume-yes))
   (assert= #f (profun-next resume-yes))

   )

  (test-definitions
   "RERUN DEEP profun-RFC"
   '(((abc x) (= 1 1) (= u k) (= 3 3)))

   (define x (get-iter '((abc 0))))
   (define first (profun-next x))
   (define second (profun-next x))

   (define resume
     (profun-RFC-insert first '((= z 3) (= w 3))))

   (assert= #f second)

   (assert= #f (profun-next x))
   (assert= #f (profun-next x))

   (assert (profun-RFC? (profun-next resume)))
   (assert= #f (profun-next resume))
   (assert= #f (profun-next resume))

   )

  (test-definitions
   "PARAMETER CASES"
   '()

   (test '((= X 7) (p1 X) (p1 Y)) '(((Y . 7) (X . 7))))

   (assert=
    "param1 = 7\n"
    (with-output-to-string
      (lambda _
        (test '((= X 7) (p1 X) (printp1 8)) '(((X . 7)))))))

   )

  (test-definitions
   "UNDERSCORE CASES"
   '(((parent "Homer" "Lisa"))
     ((parent "Homer" "Bart"))
     ((parent "Marge" "Lisa"))
     ((parent "Marge" "Bart"))
     ((parent "Abraham" "Homer"))
     ((parent "Mona" "Homer"))
     ((parent "Mr. Olsen" "Mona"))
     ((parent "Mrs. Olsen" "Mona"))
     ((parent "Bart" "Skippy"))
     )

   (test '((parent _P X) (parent _P Y) (!= X Y))
         '(((Y . "Bart") (X . "Lisa"))
           ((Y . "Lisa") (X . "Bart"))
           ((Y . "Bart") (X . "Lisa"))
           ((Y . "Lisa") (X . "Bart"))))

   (test '((parent _ X) (parent _ Y) (!= X Y))
         '(((Y . "Bart") (X . "Lisa"))
           ((Y . "Bart") (X . "Lisa"))
           ((Y . "Homer") (X . "Lisa"))
           ((Y . "Homer") (X . "Lisa"))
           ((Y . "Mona") (X . "Lisa"))
           ((Y . "Mona") (X . "Lisa"))
           ((Y . "Skippy") (X . "Lisa"))
           ((Y . "Lisa") (X . "Bart"))
           ((Y . "Lisa") (X . "Bart"))
           ((Y . "Homer") (X . "Bart"))
           ((Y . "Homer") (X . "Bart"))
           ((Y . "Mona") (X . "Bart"))
           ((Y . "Mona") (X . "Bart"))
           ((Y . "Skippy") (X . "Bart"))
           ((Y . "Bart") (X . "Lisa"))
           ((Y . "Bart") (X . "Lisa"))
           ((Y . "Homer") (X . "Lisa"))
           ((Y . "Homer") (X . "Lisa"))
           ((Y . "Mona") (X . "Lisa"))
           ((Y . "Mona") (X . "Lisa"))
           ((Y . "Skippy") (X . "Lisa"))
           ((Y . "Lisa") (X . "Bart"))
           ((Y . "Lisa") (X . "Bart"))
           ((Y . "Homer") (X . "Bart"))
           ((Y . "Homer") (X . "Bart"))
           ((Y . "Mona") (X . "Bart"))
           ((Y . "Mona") (X . "Bart"))
           ((Y . "Skippy") (X . "Bart"))
           ((Y . "Lisa") (X . "Homer"))
           ((Y . "Bart") (X . "Homer"))
           ((Y . "Lisa") (X . "Homer"))
           ((Y . "Bart") (X . "Homer"))
           ((Y . "Mona") (X . "Homer"))
           ((Y . "Mona") (X . "Homer"))
           ((Y . "Skippy") (X . "Homer"))
           ((Y . "Lisa") (X . "Homer"))
           ((Y . "Bart") (X . "Homer"))
           ((Y . "Lisa") (X . "Homer"))
           ((Y . "Bart") (X . "Homer"))
           ((Y . "Mona") (X . "Homer"))
           ((Y . "Mona") (X . "Homer"))
           ((Y . "Skippy") (X . "Homer"))
           ((Y . "Lisa") (X . "Mona"))
           ((Y . "Bart") (X . "Mona"))
           ((Y . "Lisa") (X . "Mona"))
           ((Y . "Bart") (X . "Mona"))
           ((Y . "Homer") (X . "Mona"))
           ((Y . "Homer") (X . "Mona"))
           ((Y . "Skippy") (X . "Mona"))
           ((Y . "Lisa") (X . "Mona"))
           ((Y . "Bart") (X . "Mona"))
           ((Y . "Lisa") (X . "Mona"))
           ((Y . "Bart") (X . "Mona"))
           ((Y . "Homer") (X . "Mona"))
           ((Y . "Homer") (X . "Mona"))
           ((Y . "Skippy") (X . "Mona"))
           ((Y . "Lisa") (X . "Skippy"))
           ((Y . "Bart") (X . "Skippy"))
           ((Y . "Lisa") (X . "Skippy"))
           ((Y . "Bart") (X . "Skippy"))
           ((Y . "Homer") (X . "Skippy"))
           ((Y . "Homer") (X . "Skippy"))
           ((Y . "Mona") (X . "Skippy"))
           ((Y . "Mona") (X . "Skippy"))))

   )

  (test-definitions
   "PROFUN-ERROR CASES"
   '(((parent "Homer" "Lisa"))
     ((parent "Homer" "Bart"))
     ((parent "Marge" "Lisa"))
     ((parent "Marge" "Bart"))
     ((parent "Abraham" "Homer"))
     ((parent "Mona" "Homer"))
     ((parent "Mr. Olsen" "Mona"))
     ((parent "Mrs. Olsen" "Mona"))
     ((parent "Bart" "Skippy"))
     )

   (test-error 'this-is-not-a-list '(bad-query:not-a-list))
   (test-error "this is not a list" '(bad-query:not-a-list))

   (test-error '(this is not a list) '(bad-query:expr-not-a-list))
   (test-error '("this is not a list") '(bad-query:expr-not-a-list))

   (test '(("parent" X)) '())
   )

  (test-definitions
   "PROFUN-ERROR CASES FOR RFC"
   '()

   (define x (get-iter '((= z w))))
   (define first (profun-next x))
   (define resume-not-a-list-in-list
     (profun-RFC-insert first '(this is not a list)))
   (define resume-not-a-list
     (profun-RFC-insert first 'not-a-list-in-rfc))

   (define e1 (profun-next resume-not-a-list))
   (define e2 (profun-next resume-not-a-list-in-list))

   (assert (profun-error? e1))
   (assert= (profun-error-args e1) '(bad-query:not-a-list))

   (assert (profun-error? e2))
   (assert= (profun-error-args e2) '(bad-query:expr-not-a-list))

   )

  (test-definitions
   "PROFUN-OP-FUNCTION CASES"
   '()

   (test '((fadd 3 4 z)) '(((z . 7))))
   (test '((fadd 3 4 7)) '(()))
   (test '((fadd 3 4 8)) '())
   (test-rfc '((fadd x 4 7)) '((value x)))
   (test-rfc '((fadd 3 y 7)) '((value y)))

   (test '((fdiv 777 23 q r)) '(((q . 33) (r . 18))))
   (test '((fdiv 777 23 33 r)) '(((r . 18))))
   (test '((fdiv 777 23 q 18)) '(((q . 33))))
   (test '((fdiv 777 23 33 18)) '(()))
   (test '((fdiv 777 23 22 18)) '())
   (test '((fdiv 777 23 33 28)) '())
   (test '((fdiv 777 23 22 28)) '())
   (test '((fdiv 777 23 q 28)) '())
   (test '((fdiv 777 23 22 r)) '())

   (test '((fdiv 777 0 q r)) '())

   )

  )
