
%run guile

;; profun
%use (assert=) "./src/assert-equal.scm"
%use (assert) "./src/assert.scm"
%use (catchu-case) "./src/catchu-case.scm"
%use (debugs) "./src/debugs.scm"
%use (profun-RFC-continuation profun-RFC?) "./src/profun-RFC.scm"
%use (profun-make-handler) "./src/profun-make-handler.scm"
%use (profun-make-set) "./src/profun-make-set.scm"
%use (profun-make-tuple-set) "./src/profun-make-tuple-set.scm"
%use (profun-apply-fail! profun-apply-return! profun-op-apply) "./src/profun-op-apply.scm"
%use (profun-op-divisible) "./src/profun-op-divisible.scm"
%use (profun-eval-fail! profun-op-eval) "./src/profun-op-eval.scm"
%use (profun-op-less) "./src/profun-op-less.scm"
%use (profun-op*) "./src/profun-op-mult.scm"
%use (profun-op+) "./src/profun-op-plus.scm"
%use (profun-op-separate) "./src/profun-op-separate.scm"
%use (profun-op-unify) "./src/profun-op-unify.scm"
%use (profun-create-database profun-eval-query profun-run-query) "./src/profun.scm"

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
  (profun-run-query db query))

(define (run-query query)
  (define db (get-db))
  (profun-eval-query db query))

(define (test query expected-result)
  (define result (run-query query))
  (unless (equal? expected-result result)
    (debugs expected-result)
    (debugs result))
  (assert= expected-result result))

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

(parameterize
    ((current-handler
      (profun-make-handler
       (= profun-op-unify)
       (!= profun-op-separate)
       (+ profun-op+)
       (* profun-op*)
       (< profun-op-less)
       (divisible profun-op-divisible)
       (apply profun-op-apply)
       (eval profun-op-eval)
       (favorite (profun-make-set (list 777 2 9 3)))
       (favorite2 (profun-make-tuple-set (a b) '((777 2) (#t 9) (3 #f))))
       )))

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
   (test '((abc a b)) '()) ;; because 'a ('k) is not instantiated
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
   "+ CASES"
   '()

   (test '((+ 2 3 5)) '(()))
   (test '((+ 2 3 1)) '())
   (test '((+ 2 1 5)) '())
   (test '((+ 1 3 5)) '())

   (test '((+ 2 3 z)) '(((z . 5))))
   (test '((+ 2 y 5)) '(((y . 3))))
   (test '((+ x 3 5)) '(((x . 2))))
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
   (test '((< x 4) (< y x)) '(((x . 3) (y . 2))
                              ((x . 3) (y . 1))
                              ((x . 3) (y . 0))
                              ((x . 2) (y . 1))
                              ((x . 2) (y . 0))
                              ((x . 1) (y . 0))))

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
   "apply CASES"
   '()

   (test `((= x 3) (apply ,(lambda (y) (profun-apply-return! 2)) x)) '(((x . 2))))
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
     ((parent "Homer" "Megie"))
     ((parent "Marge" "Lisa"))
     ((parent "Marge" "Bart"))
     ((parent "Marge" "Megie"))
     ((parent "Abraham" "Homer"))
     ((parent "Mona" "Homer"))
     ((parent "Mr. Olsen" "Mona"))
     ((parent "Mrs. Olsen" "Mona"))
     ((parent "Bart" "Skippy"))
     ((relative x y) (parent x y))
     ((relative x y) (parent x z) (relative z y))
     )

   (test '((parent "Homer" y)) '(((y . "Lisa")) ((y . "Bart")) ((y . "Megie"))))
   (test '((parent x "Lisa")) '(((x . "Homer")) ((x . "Marge"))))
   (test '((parent x "Lisa")) '(((x . "Homer")) ((x . "Marge"))))
   (test '((relative "Bart" y)) '(((y . "Skippy"))))
   (test '((relative "Homer" "Skippy")) '(()))
   (test '((relative "Homer" "Mona")) '())
   (test '((relative "Mr. Olsen" y)) '(((y . "Mona"))
                                       ((y . "Homer"))
                                       ((y . "Lisa"))
                                       ((y . "Bart"))
                                       ((y . "Megie"))
                                       ((y . "Skippy"))))

   )

  (test-definitions
   "IGNORE profun-RFC IN QUERY"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (define threw #f)

   (catchu-case
    (run-query '((= z w)))
    (('profun-needs-more-info what)
     (set! threw #t)))

   (assert threw)

   )

  (test-definitions
   "IGNORE profun-RFC"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (define x
     (get-iter '((= z w))))
   (assert (profun-RFC? (x)))
   (assert= #f (x))
   (assert= #f (x))

   )

  (test-definitions
   "RERUN profun-RFC"
   '(((abc x) (= x 1))
     ((abc x) (= x 2))
     ((abc x) (= x 3)))

   (define x (get-iter '((= z w))))
   (define first (x))
   (define second (x))
   (define cont (profun-RFC-continuation first))

   (define resume-yes (cont '() '((= z 3) (= w 3))))
   (define resume-no  (cont '() '((= z 3) (= w 4))))

   (assert= #f second)

   (assert= #f (resume-no))
   (assert= #f (resume-no))

   (assert= (resume-yes) '((z . 3) (w . 3)))
   (assert= #f (resume-yes))
   (assert= #f (resume-yes))

   )

  (test-definitions
   "RERUN DEEP profun-RFC"
   '(((abc x) (= 1 1) (= u k) (= 3 3)))

   (define x (get-iter '((abc 0))))
   (define first (x))
   (define cont (profun-RFC-continuation first))
   (define resume (cont '() '((= z 3) (= w 3))))
   (assert= #f (x))
   (assert= #f (x))
   (assert (profun-RFC? (resume)))
   (assert= #f (resume))
   (assert= #f (resume))

   )

  )
