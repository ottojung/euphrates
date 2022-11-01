
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (syntax-append) "./src/syntax-append.scm"

(let () ;; syntax-append
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert= (list 'arg 2 3 4 5 6 7)
           (syntax-append (cont 'arg) (2 3) (4 5 6 7))))
