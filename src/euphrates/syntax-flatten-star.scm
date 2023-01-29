
(cond-expand
 (guile
  (define-module (euphrates syntax-flatten-star)
    :export (syntax-flatten*)
    :use-module ((euphrates syntax-reverse) :select (syntax-reverse)))))

;;; Fully flattens syntax tree, so that ((a b (c (g h) d) (h) e)) becomes (a b c g h d h e)


(define-syntax syntax-flatten*-aux
  (syntax-rules ()
    [(_ cont ((xs ...) ys ...) (result ...))
     (syntax-flatten*-aux cont (xs ... ys ...) (result ...))]
    [(_ cont (x xs ...) (result ...))
     (syntax-flatten*-aux cont (xs ...) (x result ...))]
    [(_ cont () (result ...))
     (syntax-reverse cont (result ...))]))

(define-syntax syntax-flatten*
  (syntax-rules ()
    ((_ cont xs)
     (syntax-flatten*-aux cont xs ()))))
