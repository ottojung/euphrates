
%run guile

%var monad-lazy

%use (dynamic-thread-async) "./dynamic-thread-async.scm"
%use (memconst) "./memconst.scm"
%use (monad-arg monad-ret/thunk) "./monad.scm"
%use (monadarg-lval monadarg-qtags) "./monadarg.scm"
%use (monadfin?) "./monadfin.scm"

;; Provides lazy evaluation, with "async" feature
(define monad-lazy
  (lambda (monad-input)
    (if (monadfin? monad-input) monad-input
        (let* ((result
                (if (memq 'async (monadarg-qtags monad-input))
                    (dynamic-thread-async (monad-arg monad-input))
                    (monadarg-lval monad-input))))
          (monad-ret/thunk monad-input result)))))
