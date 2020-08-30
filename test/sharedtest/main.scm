
(with-ignore-errors!
 (throw 'test "arg1" "arg2"))

;; mdict
(let ()
  (let ((zz (mdict 1 2
                   3 4)))
    (assert-equal (zz 3)
                  4)
    (let ((z2 (zz 3 99)))
      (assert-equal (z2 3)
                    99)
      (assert (mdict-has? z2 3))
      (assert (not (mdict-has? z2 52)))
      (let ((z3 (z2 52 2)))
        (assert (mdict-has? z3 52))
        (mdict-set! z3 52 9)
        (assert-equal (z3 52) 9)))))

;; words / unwords
(let ()
  (assert-equal
   (words "hello \t \t \n world!")
   (list "hello" "world!"))

  (assert-equal
   (unwords (list "hello" "world!"))
   "hello world!"))

;; list->tree
(let ()
  (define ex
    (map string->symbol
         (words "hello < define ex < words x > > bye")))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list x)))
       ((equal? '> x)
        (values 'close (list x)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert-equal
     r
     '(hello
       (< define ex (< words x >) >)
       bye)))

  (let ()
    (define (divider x xs)
      (cond
       ((equal? '< x)
        (values 'open (list)))
       ((equal? '> x)
        (values 'close (list)))
       (else
        (values #f #f))))

    (define r (list->tree ex divider))

    (assert-equal
     r
     '(hello
       (define ex (words x))
       bye))))

;; list-traverse
(let ()
  (assert-equal
   6
   (list-traverse
    (range 10)
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t xs)))))

  (assert-equal
   'custom-default
   (list-traverse
    (range 10)
    'custom-default
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t (list)))))))

;; package
(let ()
  (define already-defined 7)

  (define x
    (with-svars [already-defined]
                (lambda (c) (list already-defined c))))

  (define y
    ((use-svars x (b 2) (already-defined 1)) 4))

  (define z
    ((x) 4))

  (define p
    (make-package [already-defined]
                  [[foo (lambda (c) (list already-defined c))]
                   [bar (lambda (c) (list c already-defined))]
                   [baz 3]]))

  (define p-inst (p (cons 'already-defined 22)))
  (define foo-inst (hash-ref p-inst 'foo))

  (assert-equal y (list 1 4))
  (assert-equal z (list 7 4))

  (assert-equal
   (list 22 2)
   (foo-inst 2))

  (assert-equal
   (list 3 2)
   (with-package
    [p [b 2] [already-defined 3]]
    [foo bar baz]
    (begin
      (foo 2))))

  (assert-equal
   (list 7 2)
   (with-package
    p
    [foo bar baz]
    (begin
      (foo 2))))

  (assert-equal
   (list 7 2)
   (with-package
    [p]
    [foo bar baz]
    (begin
      (foo 2)))))

(define k (letin
           [i 2]
           [c 3]
           (+ i c)))

(assert-equal (list 0 'x 1 'x 2)
              (list-intersperse 'x (list 0 1 2)))
(assert-equal (list 0)
              (list-intersperse 'x (list 0)))
(assert-equal (list)
              (list-intersperse 'x (list)))
(assert-equal 199
              (length (list-intersperse 'x (range 100))))

(catch-any
 (lambda ()
   (throw 'test1 1 2 3 4))
 (lambda err
   (dprintln "err: ~A" err)
   (assert-equal 1 (length err))))

(assert-equal
 "file.b.c"
 (path-replace-extension "file.b.a" ".c"))

;; (define-rec-strs "rec1" "aa" "bb")
(define-rec rec1 aa bb)

(define rec (rec1 1 2))

(dprintln "record? ~a" (record? rec))
(dprintln "aa = ~a" (rec1-aa rec))
(set-rec1-aa! rec 10)
(dprintln "aa = ~a" (rec1-aa rec))

(printf "loop = ~a\n" (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1))))))

(printf "k = ~a\n" k)

(let* ((s "xxhellokh")
       (tt "hx")
       (test
        (fn mode
            (dprintln "trim of ~s with ~s in mode ~a: ~a"
                     s
                     tt
                     mode
                     (string-trim-chars s tt mode)))))
  (test 'left)
  (test 'right)
  (test 'both))

(+ 5 10)

(display "Hello, Guile!\n")

;; (dprintln "tree:\n~a\n\n" (directory-tree "."))
(dprintln "files:\n~a\n\n" (directory-files "."))
;; (dprintln "files-rec:\n~a\n\n" (directory-files-rec "."))
;; (dprintln "rec only names:\n~a\n\n" (map cadr (directory-files-rec ".")))

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
              [p (dprintln "after kek") 'always]
              [r (set! ran-always #t) 'always]
              [c (- b b)]
              (+ 100 c))
     (set! throwed #f))
   (lambda errs
     (dprintln "except-monad throwed: ~a" errs)))
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
              [p (dprintln "after kek") 'always]
              [r (set! ran-always #t) 'always]
              [c (- b b)]
              (+ 100 c))
     (set! throwed #f))
   (lambda errs
     (dprintln "except-monad throwed: ~a" errs)))
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

(dprintln "~a" (list-fold 1 (range 1 5) *))
(dprintln "~a" (list-fold 1 (range 1 5) (lambda [acc x] (* acc x))))
(dprintln "~a" (lfold 1 (range 1 5) (* acc x)))

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
;; (dprintln (append-posix-path "hello/there" "/bro"))

(assert-equal
  (path-rebase "hello/there/" "kek")
  #f)
(assert-equal
  (path-rebase "hello/there/" "hello/kek/kek")
  "hello/there/kek/kek")
(assert-equal
  (path-rebase "hello/there/" "hello/here/kek")
  "hello/there/here/kek")

(assert-equal
 (take-common-prefix "abcd" "abee")
 "ab")
(assert-equal
 (take-common-prefix "abcd" "")
 "")
(assert-equal
 (take-common-prefix "" "abcd")
 "")
(assert-equal
 (take-common-prefix "" "")
 "")

(assert-equal
 (remove-common-prefix "abcd" "abee")
 "cd")
(assert-equal
 (remove-common-prefix "abcd" "")
 "abcd")
(assert-equal
 (remove-common-prefix "" "abcd")
 "")
(assert-equal
 (remove-common-prefix "" "")
 "")

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
 (define [kek]
   (dprintln "in kek"))

 (define cycles 4)

 (define zulul-thread #f)

 (define [lol]
   (apploop [n] [0]
            (if (> n cycles)
                (dprintln "lol ended")
                (begin
                  (when (= n 2)
                    (dynamic-thread-cancel zulul-thread))
                  (dprintln "lol at ~a" n)
                  (dynamic-thread-yield)
                  (dprintln "lol after ~a" n)
                  (loop (1+ n))))))

 (define [zulul]
   (apploop [n] [0]
            (if (> n cycles)
                (dprintln "zulul ended")
                (begin
                  (dprintln "zulul at ~a" n)
                  (dynamic-thread-yield)
                  (dprintln "zulul after ~a" n)
                  (loop (1+ n))))))

 (dprintln "hello")

 (dynamic-thread-spawn kek)
 (dynamic-thread-spawn lol)
 (set! zulul-thread (dynamic-thread-spawn zulul))

 (dprintln "end"))

;;;;;;;;;;;;;;;;
;; FILESYSTEM ;;
;;;;;;;;;;;;;;;;

(let* [[temp (make-temporary-filename)]
       [curfile (get-current-source-file-path)]]
  (dprintln "cur file = ~a" curfile)
  (let [[text (read-string-file curfile)]]
    (dprintln "text = <~a>" (car
                             (filter
                              (compose not string-null?)
                              (string-split#simple text #\newline))))
    (write-string-file temp text)
    (let [[temp-text (read-string-file temp)]]
      (assert-equal text temp-text))))

;;;;;;;;;;;;;
;; SCRIPTS ;;
;;;;;;;;;;;;;

(parse-cli-global-default
  (parse-cli
   (list
    "filename" "--key1" "val1" "-opt1" "--key2" "val2" "--" "rest1" "rest2"
    )))

(dprintln "parsed = ~a" (parse-cli-parse-or-get!))

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

