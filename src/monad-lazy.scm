
%run guile

%var monad-lazy

%use (dynamic-thread-async) "./dynamic-thread-async.scm"
%use (monad-make/simple) "./monad-make-simple.scm"
%use (monad-arg monad-ret/thunk) "./monad.scm"
%use (monadarg-lval monadarg-qtags) "./monadarg.scm"

;; Provides lazy evaluation, with "async" feature
(define monad-lazy
  (monad-make/simple
   (monad-input)
   (define result
     (if (memq 'async (monadarg-qtags monad-input))
         (dynamic-thread-async (monad-arg monad-input))
         (monadarg-lval monad-input)))
   (monad-ret/thunk monad-input result)))
