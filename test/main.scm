
%run guile

%use (run-comprocess#p-default) "./../src/run-comprocess.scm"
%use (make-uni-spinlock) "./../src/uni-spinlock.scm"
%use (debug) "./../src/debug.scm"
%use (with-ignore-errors!) "./../src/with-ignore-errors.scm"
%use (random-choice) "./../src/random-choice.scm"
%use (printable#alphabet) "./../src/printable-alphabet.scm"
%use (catch-any) "./../src/catch-any.scm"
%use (assert) "./../src/assert.scm"
%use (assert=) "./../src/assert=.scm"
%use (make-queue queue-empty? queue-peek queue-push! queue-pop!) "./../src/queue.scm"
%use (with-dynamic) "./../src/with-dynamic.scm"
%use (lazy-parameter) "./../src/lazy-parameter.scm"
%use (~a) "./../src/~a.scm"
%use (~s) "./../src/~s.scm"
%use (hash->mdict ahash->mdict mdict mdict-has? mdict-set! mdict->alist mdict-keys) "./../src/mdict.scm"

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

(display "All good\n")

