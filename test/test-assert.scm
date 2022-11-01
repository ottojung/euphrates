
%run guile

%use (assert) "./src/assert.scm"
%use (catch-any) "./src/catch-any.scm"

(let () ;; assert
  (catch-any
   (lambda _ (assert (= (+ 3 2) (- 10 3))))
   (lambda errors
     (assert
      (equal? errors
              '((assertion-fail (test: (= 5 7)) (original: (= (+ 3 2) (- 10 3))))))))))
