
%run guile

%var flatten-syntax-f
%var flatten-syntax-f-arg

%use (syntax-reverse) "./syntax-reverse.scm"

(define-syntax flatten-syntax-f-arg-aux
  (syntax-rules ()
    [(_ f arg ((xs ...) ys ...) (result ...))
     (flatten-syntax-f-arg-aux f arg (xs ... ys ...) (result ...))]
    [(_ f arg (x xs ...) (result ...))
     (flatten-syntax-f-arg-aux f arg (xs ...) (x result ...))]
    [(_ f arg () (result ...))
     (syntax-reverse (f arg) (result ...))]))

(define-syntax flatten-syntax-f-aux
  (syntax-rules ()
    [(_ f ((xs ...) ys ...) (result ...))
     (flatten-syntax-f-aux f (xs ... ys ...) (result ...))]
    [(_ f (x xs ...) (result ...))
     (flatten-syntax-f-aux f (xs ...) (x result ...))]
    [(_ f () (result ...))
     (syntax-reverse f (result ...))]))

(define-syntax flatten-syntax-f-arg
  (syntax-rules ()
    ((flatten-syntax-f f f-arg xs)
     (flatten-syntax-f-arg-aux f f-arg xs ()))))
(define-syntax flatten-syntax-f
  (syntax-rules ()
    ((flatten-syntax-f f xs)
     (flatten-syntax-f-aux f xs ()))))
