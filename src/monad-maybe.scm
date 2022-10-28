
%run guile

%var monad-maybe

%use (monad-make/simple) "./monad-make-simple.scm"
%use (monad-arg monad-cret monad-ret) "./monad.scm"

(define (monad-maybe predicate)
  (monad-make/simple
   (monad-input)
   (call-with-values
       (lambda _ (monad-arg monad-input))
     (lambda args
       (if (apply predicate args)
           (monad-cret monad-input args identity)
           (monad-ret  monad-input args))))))
