
(define k (letin
           [i 2]
           [c 3]
           (+ i c)))

(assert-equal
 "file.b.c"
 (path-replace-extension "file.b.a" ".c"))

(assert-equal
 (words "hello \t \t \n world!")
 (list "hello" "world!"))

(assert-equal
 (unwords (list "hello" "world!"))
 "hello world!")

;; (define-rec-strs "rec1" "aa" "bb")
(define-rec rec1 aa bb)

(define rec (rec1 1 2))

(printfln "record? ~a" (record? rec))
(printfln "aa = ~a" (rec1-aa rec))
(set-rec1-aa! rec 10)
(printfln "aa = ~a" (rec1-aa rec))

(printf "loop = ~a\n" (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1))))))

(printf "k = ~a\n" k)

(let* ((s "xxhellokh")
       (tt "hx")
       (test
        (fn mode
            (printfln "trim of ~s with ~s in mode ~a: ~a"
                     s
                     tt
                     mode
                     (string-trim-chars s tt mode)))))
  (test 'left)
  (test 'right)
  (test 'both))

(+ 5 10)

(display "Hello, Guile!\n")

;; (printfln "tree:\n~a\n\n" (directory-tree "."))
(printfln "files:\n~a\n\n" (directory-files "."))
;; (printfln "files-rec:\n~a\n\n" (directory-files-rec "."))
;; (printfln "rec only names:\n~a\n\n" (map cadr (directory-files-rec ".")))

;; scoping test
(apploop [x] [20]
		 (printf "up ~a\n" x)
		 (unless (> x 24)
		   (let [[z 10]]
			 (apploop [x] [3]
					  (printf "dw ~a\n" x)
					  (if (= x 0)
						  x
						  (loop (1- x))))
			 (loop (1+ x)))))

(define x (printf "z = ~a\n" (* 2/3 1/3)))

(printf "x = ~a\n" x)

(define zzz 20)

(+ zzz zzz)

(printf "fn = ~a\n" ((fn i (* 2 i)) 5))


;; monads {

(define [calc-default]
  (monadic (maybe-monad (fn x (= x 0)))
           [a (+ 2 7)]
           [b (* a 10)]
           [c (- b b)]
           (+ 100 c)))

(assert-equal (calc-default) 0)

(assert-equal
 1
 (monadic-parameterize
  (fn f fname
      (lambda monadic-input
        (let-values (((arg cont qvar qval qtags) (apply f monadic-input)))
          (values (const (1+ (arg))) cont qvar qval qtags))))
  (calc-default)))

(assert-equal
 0
 (monadic (compose log-monad (maybe-monad (fn x (= x 0))))
          [a (+ 2 7)]
          [b (* a 10)]
          [c (- b b)]
          (+ 100 c)))

(assert-equal
 100
 (monadic log-monad
          [a (+ 2 7)]
          [b (* a 10)]
          [c (- b b)]
          (+ 100 c)))

(assert-equal
 0
 (with-monadic-right
  (maybe-monad (fn x (= x 0)))
  (monadic log-monad
           [a (+ 2 7)]
           [b (* a 10)]
           [c (- b b)]
           (+ 100 c))))

(define count-monad-counter 0)
(define count-monad
  (lambda monad-input
    (set! count-monad-counter
      (1+ count-monad-counter))
    (apply values monad-input)))

(with-monadic-left
 count-monad
 (assert-equal
  0
  (with-monadic-right
   (maybe-monad (fn x (= x 0)))
   (monadic log-monad
            [a (+ 2 7)]
            [b (* a 10)]
            [c (- b b)]
            [d (+ 2 3)]
            (+ 100 c)))))

(assert-equal 3 count-monad-counter)

(let ((ran-always #f)
      (throwed #t))
  (catch-any
   (lambda ()
     (monadic (except-monad)
              [a (+ 2 7)]
              [b (throw 'test-abort)]
              [p (printfln "after kek") 'always]
              [r (set! ran-always #t) 'always]
              [c (- b b)]
              (+ 100 c))
     (set! throwed #f))
   (lambda errs
     (printfln "except-monad throwed: ~a" errs)))
  (assert ran-always)
  (assert throwed))

(let ((ran-always #f)
      (throwed #t))
  (catch-any
   (lambda ()
     (monadic (compose log-monad (except-monad))
              [a (+ 2 7)]
              [[k d] (values 2 3)]
              [[b y] (throw 'test-abort)]
              [p (printfln "after kek") 'always]
              [r (set! ran-always #t) 'always]
              [c (- b b)]
              (+ 100 c))
     (set! throwed #f))
   (lambda errs
     (printfln "except-monad throwed: ~a" errs)))
  (assert ran-always)
  (assert throwed))

(let ((eval-b-count 0))
  (assert-equal
   550
   ((monadic (compose log-monad lazy-monad)
             [a (+ 2 7)]
             [b (begin
                  (set! eval-b-count (1+ eval-b-count))
                  (* (a) 10))]
             [z (throw 'should-not-be-evaluated)]
             [c (+ (b) (b) (b) (b) (b))]
             [[k d] (values 2 3)]
             [sum (+ (k) (d))]
             (begin
               (assert-equal (sum) 5)
               (+ 100 (c))))))

  (assert-equal 1 eval-b-count))

(let ((eval-b-count 0))
  (assert-equal
   550
   ((monadic (compose log-monad lazy-monad)
             [a (+ 2 7) 'async]
             [b (begin
                  (set! eval-b-count (1+ eval-b-count))
                  (* (a) 10))]
             [z (throw 'should-not-be-evaluated)]
             [c (+ (b) (b) (b) (b) (b))]
             [[k d] (values 2 3) 'async]
             [sum (+ (k) (d))]
             (begin
               (assert-equal (sum) 5)
               (+ 100 (c))))))

  (assert-equal 1 eval-b-count))

;; } monads

(gfunc/define haha)

;; (gfunc/instantiate-haha (list integer?) (lambda (i) (* i 2)))
(gfunc/instance haha [integer?]
                (fn i (* i 10)))

(gfunc/instantiate-haha (list) (lambda () 'no-arguments))
;; (gfunc/instance haha []
;;                 (fn 2))

(assert-equal 'no-arguments (haha))
(assert-equal 50 (haha 5))

(printfln "~a" (list-fold 1 (range 1 5) *))
(printfln "~a" (list-fold 1 (range 1 5) (lambda [acc x] (* acc x))))
(printfln "~a" (lfold 1 (range 1 5) (* acc x)))

(assert-equal
 (simplify-posix-path "/hello/../there/./bro/")
 "/there/bro/")
(assert-equal
 (append-posix-path "hello/there/" "bro")
 "hello/there/bro")
(assert-equal
 (append-posix-path "hello/there" "bro")
 "hello/there/bro")
(assert-equal
 (append-posix-path "hello/there" ".." "and/" "bro" "." "hello")
 "hello/there/../and/bro/./hello")
(assert-equal
 (simplify-posix-path
  (append-posix-path "hello/there" ".." "and/" "bro" "." "hello"))
 "hello/and/bro/hello")
;; (printfln (append-posix-path "hello/there" "/bro"))

(assert-equal
  (path-rebase "hello/there/" "kek")
  #f)
(assert-equal
  (path-rebase "hello/there/" "hello/kek/kek")
  "hello/there/kek/kek")
(assert-equal
  (path-rebase "hello/there/" "hello/here/kek")
  "hello/there/here/kek")

(define [hell2 x]
  (with-return
   (printf "hahaha\n")
   (printf "job = ~a\n" 2)
   (return 55)
   (+ 2 x)))

(assert-equal 55 (hell2 50))

(assert-equal
 10
 (call-with-finally#return
  (lambda [return]
    (printf "locked\n")
    10)
  (lambda []
    (printf "unlocked\n"))))

(assert-equal
 5
 (call-with-finally#return
  (lambda [return]
    (printf "locked\n")
    (return 5)
    (printf "should not happend\n"))
  (lambda []
    (printf "unlocked\n"))))

;; (catch #t
;;   (lambda []

;;     (call-with-finally#return
;;      (lambda [return]
;;        (printf "locked 'ex\n")
;;        (throw 'kek)
;;        (printf "should not happend\n"))
;;      (lambda []
;;        (printf "unlocked 'ex\n"))))

;;   (lambda args
;;     (printf "~a\n" args)))

(call-with-finally#return
 (lambda [return]
   (printf "composite locked\n")

   ;; (return 2)

   (call-with-finally#return
    (lambda [return2]
      (printf "composite locked 2\n")
      ;; (return 5)

      (call-with-finally#return
       (lambda [return3]
         (printf "composite locked 3\n")
         (return 5)
         ;; (throw 'zzz 55)
         ;; (return2 7)
         ;; (return3 9)
         (printf "should not happend\n"))
       (lambda []
         (printf "composite unlocked 3\n")))

      ;; (return2 7)
      (printf "maybe should happend 2\n"))
    (lambda []
      (printf "composite unlocked 2\n")))

   (printf "maybe should happend\n"))
 (lambda []
   (printf "composite unlocked\n")))

(with-np-thread-env#non-interruptible
 (printfln "hello")

 (define [kek]
   (printfln "in kek"))

 (define cycles 4)

 (define zulul-thread #f)

 (define [lol]
   (apploop [n] [0]
            (if (> n cycles)
                (printfln "lol ended")
                (begin
                  (when (= n 2)
                    (dynamic-thread-cancel zulul-thread))
                  (printfln "lol at ~a" n)
                  (dynamic-thread-yield)
                  (printfln "lol after ~a" n)
                  (loop (1+ n))))))

 (define [zulul]
   (apploop [n] [0]
            (if (> n cycles)
                (printfln "zulul ended")
                (begin
                  (printfln "zulul at ~a" n)
                  (dynamic-thread-yield)
                  (printfln "zulul after ~a" n)
                  (loop (1+ n))))))

 (dynamic-thread-spawn kek)
 (dynamic-thread-spawn lol)
 (set! zulul-thread (dynamic-thread-spawn zulul))

 (printfln "end"))


;;;;;;;;;;;;;;;;
;; STACK FLOW ;;
;;;;;;;;;;;;;;;;

(define/stack [ADD-TO-7]
  (PUSH 7)
  ADD)

(printfln
 "stack result = ~a"
 (st
  (PUSH 2)
  (PUSH 3)
  ADD
  (PUSH 5)
  MUL
  ADD-TO-7
  (lambda [x] (printfln "stack op1 result = ~a" x) x)
  NEGATE
  (PUSH 100)
  ADD))

(define stack-k #f)

(printfln
 "stack result = ~a"
 (st
  (PUSH 2)
  (PUSH 3)
  ADD
  PUSH/CC
  (USE (lambda [k]
    (printfln "got k = ~a" k)
    (if (procedure? k)
        (begin
          (set! stack-k k)
          5)
        (begin
          (set! stack-k (lambda lst 77))
          77))))
  MUL
  (CALL
   (lambda [n]
     (printfln "MUL result = ~a" n)
     (printfln "AFTER CALL TO ~a" (stack-k (list n)))
     n))
  (PUSH "END")
  PRINT))

(st
 (PUSH "PROJ and MAP test")
 PRINT
 (PUSH (list 2 3))
 (PROJ car cadr)
 (MAP (STORE x) (STORE y))
 (lambda [x y] (printfln "x = ~a ; y = ~a" x y) x)
 (LOAD x)
 (lambda [x] (printfln "LOAD x = ~a" x) x)
 (LOAD y)
 (lambda [x] (printfln "LOAD y = ~a" x) x))

(st
 (PUSH "GOTO test")
 PRINT
 (PUSH 0)
 (STORE x)
 PUSH/CC
 (STORE/DEFAULT cont1)
 (LOAD x)
 (PUSH 1)
 ADD
 (STORE x)
 (lambda [x] (printfln "LOAD x = ~a" x) x)
 (lambda [x]
   (if (< x 10)
       (GOTO (LOAD cont1))
       identity))
 EVAL
 (LOAD x)
 (lambda [x] (printfln "LOAD-end x = ~a" x) x))

(st
 (PUSH "GOTO test 2")
 PRINT
 (PUSH 0)
 (STORE x)
 PUSH/CC
 (STORE/DEFAULT cont1)
 (LOAD x)
 (PUSH 1)
 ADD
 (STORE x)
 (lambda [x] (printfln "LOAD x = ~a" x) x)
 (lambda [x] (< x 10))
 (PUSH (GOTO (LOAD cont1)))
 (PUSH identity)
 IF-THEN-ELSE
 EVAL
 (LOAD x)
 (lambda [x] (printfln "LOAD-end x = ~a" x) x))

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(let [[curfile (get-current-source-file-path)]]
  (printfln "cur file = ~a" curfile)
  (let [[text (read-string-file curfile)]]
    (printfln "text = ~a" (car (string-split#simple text #\newline)))
    (write-string-file curfile text)))

;;;;;;;;;;;;;
;; SCRIPTS ;;
;;;;;;;;;;;;;

(parse-cli-global-default
  (parse-cli
   (list
    "filename" "--key1" "val1" "-opt1" "--key2" "val2" "--" "rest1" "rest2"
    )))

(printfln "parsed = ~a" (parse-cli-parse-or-get!))

(assert-equal #t
              (parse-cli-get-flag "key1"))
(assert-equal "val1"
              (parse-cli-get-switch "key1"))
(assert-equal #f
              (parse-cli-get-flag "key9"))
(assert-equal #t
              (parse-cli-get-flag "key9" "key1"))
(assert-equal #f
              (parse-cli-get-flag "key9" "key7"))
(assert-equal (list "rest1" "rest2")
              (parse-cli-get-list ""))
(assert-equal (list "filename")
              (parse-cli-get-list #f))

;;;;;;;;;;;;;;;;;;;;
;; dynamic-thread ;;
;;;;;;;;;;;;;;;;;;;;

(assert-equal 777 ((dynamic-thread-async 3 777)))

