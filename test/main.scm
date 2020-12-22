
%run guile

%use (run-comprocess#p-default) "./../src/run-comprocess.scm"
%use (make-uni-spinlock) "./../src/uni-spinlock.scm"
%use (debug) "./../src/debug.scm"
%use (with-ignore-errors!) "./../src/with-ignore-errors.scm"
%use (random-choice) "./../src/random-choice.scm"
%use (printable#alphabet) "./../src/printable-alphabet.scm"
%use (catch-any) "./../src/catch-any.scm"
%use (assert) "./../src/assert.scm"

(let ()
  (catch-any
   (lambda _ (assert (= (+ 3 2) (- 10 3))))
   (lambda errors
     (assert
      (equal? errors
              '((assertion-fail (test: (= 5 7)) (original: (= (+ 3 2) (- 10 3))))))))))

(let ()
  (assert (equal? 5 (string-length (list->string (random-choice 5 printable#alphabet))))))





