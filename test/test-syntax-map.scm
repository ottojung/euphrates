
%run guile

%use (assert=) "./src/assert-equal.scm"
%use (syntax-map) "./src/syntax-map.scm"

(let () ;; syntax-map
  (define-syntax cont
    (syntax-rules () ((_ arg buf) (list arg . buf))))

  (assert=
   '(arg (p . 1) (p . 2) (p . 3) (p . 4) (p . 5))
   (syntax-map (cont 'arg) cons 'p (1 2 3 4 5))))
