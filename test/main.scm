
%run guile

%use (run-comprocess#p-default) "./src/run-comprocess.scm"
%use (make-uni-spinlock) "./src/uni-spinlock.scm"
%use (debug) "./src/debug.scm"
%use (with-ignore-errors!) "./src/with-ignore-errors.scm"
%use (random-choice) "./src/random-choice.scm"
%use (printable#alphabet) "./src/printable-alphabet.scm"
%use (catch-any) "./src/catch-any.scm"
%use (assert) "./src/assert.scm"
%use (assert=) "./src/assert-equal.scm"
%use (make-queue queue-empty? queue-peek queue-push! queue-pop!) "./src/queue.scm"
%use (with-dynamic) "./src/with-dynamic.scm"
%use (lazy-parameter) "./src/lazy-parameter.scm"
%use (~a) "./src/tilda-a.scm"
%use (~s) "./src/tilda-s.scm"
%use (hash->mdict ahash->mdict mdict mdict-has? mdict-set! mdict->alist mdict-keys) "./src/mdict.scm"
%use (words) "./src/words.scm"
%use (unwords) "./src/unwords.scm"
%use (list->tree) "./src/list-to-tree.scm"
%use (list-traverse) "./src/list-traverse.scm"
%use (range) "./src/range.scm"
%use (use-svars with-svars with-package make-package make-static-package) "./src/package.scm"
%use (letin) "./src/letin.scm"
%use (list-intersperse) "./src/list-intersperse.scm"

(let ()
  (catch-any
   (lambda _ (assert (= (+ 3 2) (- 10 3))))
   (lambda errors
     (assert
      (equal? errors
              '((assertion-fail (test: (= 5 7)) (original: (= (+ 3 2) (- 10 3))))))))))

(let ()
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable#alphabet))))))

(let ()
  (with-ignore-errors!
   (throw 'test "arg1" "arg2")))

;; queue
(let ()
  (define q (make-queue 1))

  (queue-push! q 1)
  (queue-push! q 2)
  (queue-push! q 3)

  (assert= (queue-peek q) 1)
  (assert= (queue-pop! q) 1)
  (assert= (queue-peek q) 2)
  (assert= (queue-pop! q) 2)

  (assert (not (queue-empty? q)))

  (queue-push! q 9)
  (assert= (queue-pop! q) 3)
  (queue-push! q 8)
  (assert= (queue-pop! q) 9)
  (queue-push! q 7)
  (assert= (queue-pop! q) 8)
  (assert= (queue-pop! q) 7)

  (assert (queue-empty? q)))


;; lazy-parameter, with-dynamic
(let ()
  (define test 1)
  (define x (lazy-parameter (begin (set! test 3) 2)
                            (lambda (z) (string->number (~a z)))))
  (define y (make-parameter 9))

  (assert= test 1)
  (assert= (y) 9)

  (with-dynamic ((x 4) (y 5))
                (assert= (y) 5)
                (assert= (x) 4)
                (assert= test 1))

  (assert= test 1)
  (assert= (x) 2)
  (assert= test 3))

;; mdict
(let ()
  (let ((zz (mdict 1 2
                   3 4)))
    (assert= (zz 3)
                  4)
    (let ((z2 (zz 3 99)))
      (assert= (z2 3)
                    99)
      (assert (mdict-has? z2 3))
      (assert (not (mdict-has? z2 52)))
      (let ((z3 (z2 52 2)))
        (assert (mdict-has? z3 52))
        (mdict-set! z3 52 9)
        (assert= (z3 52) 9)))))

;; words / unwords
(let ()
  (assert=
   (words "hello \t \t \n world!")
   (list "hello" "world!"))

  (assert=
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

    (assert=
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

    (assert=
     r
     '(hello
       (define ex (words x))
       bye))))

;; list-traverse
(let ()
  (assert=
   6
   (list-traverse
    (range 10)
    (lambda (x xs)
      (if (< 5 x)
          (values #f x)
          (values #t xs)))))

  (assert=
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

  (assert= y (list 1 4))
  (assert= z (list 7 4))

  (assert=
   (list 22 2)
   (foo-inst 2))

  (assert=
   (list 3 2)
   (with-package
    [p [b 2] [already-defined 3]]
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    p
    [foo bar baz]
    (begin
      (foo 2))))

  (assert=
   (list 7 2)
   (with-package
    [p]
    [foo bar baz]
    (begin
      (foo 2)))))

;; letin
(let ()
  (letin
   [k (letin
       [i 2]
       [c 3]
       [r (+ i c)])]
   (do (assert= k 5))
   [[c k] (letin
           [i 2]
           [(c k) (values 3 4)]
           [[r m] (values (+ i c k) 0)])]
   (do (assert= c 9))
   (do (assert= k 0))))

;; list-intersperse
(let ()
  (assert= (list 0 'x 1 'x 2)
           (list-intersperse 'x (list 0 1 2)))
  (assert= (list 0)
           (list-intersperse 'x (list 0)))
  (assert= (list)
           (list-intersperse 'x (list)))
  (assert= 199
           (length (list-intersperse 'x (range 100)))))

(display "All good\n")

