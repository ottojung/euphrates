
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




(display "All good\n")

