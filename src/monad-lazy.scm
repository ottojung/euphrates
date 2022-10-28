
%run guile

%var monad-lazy

%use (dynamic-thread-async) "./dynamic-thread-async.scm"
%use (monad-make/simple) "./monad-make-simple.scm"
%use (monad-arg monad-ret/thunk) "./monad.scm"
%use (monadstate-lval monadstate-qtags) "./monadstate.scm"

;; Provides lazy evaluation, with "async" feature
(define monad-lazy
  (monad-make/simple
   (monad-input)
   (define result
     (if (memq 'async (monadstate-qtags monad-input))
         (dynamic-thread-async
          (call-with-values
              (lambda _ (monad-arg monad-input))
            list))
         (monadstate-lval monad-input)))
   (monad-ret/thunk monad-input result)))
