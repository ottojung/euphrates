
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (syntax-flatten*) "./src/syntax-flatten-star.scm"

(let () ;; syntax-flatten-star
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg (quote buf)))))

  (assert= (list 'arg '(a b c g h d h e))
           (syntax-flatten* (cont 'arg) ((a b (c (g h) d) (h) e)))))
