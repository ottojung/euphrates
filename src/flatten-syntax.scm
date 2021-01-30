
%run guile

%var flatten-syntax

(define-syntax reverse-macro
  (syntax-rules ()
    [(_ () (result ...)) (result ...)]
    [(_ (x xs ...) (result ...)) (reverse-macro (xs ...) (x result ...))]))

(define-syntax flatten-syntax-aux
  (syntax-rules ()
    [(_ ((xs ...) ys ...) (result ...))
     (flatten-syntax-aux (xs ... ys ...) (result ...))]
    [(_ (x xs ...) (result ...))
     (flatten-syntax-aux (xs ...) (x result ...))]
    [(_ () (result ...))
     (reverse-macro (result ...) ())]))

(define-syntax-rule (flatten-syntax xs)
  (flatten-syntax-aux xs ()))
