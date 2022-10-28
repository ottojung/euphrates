
%run guile

%var monad-except

%use (monadstate-lval monadstate-qtags) "./monadstate.scm"
%use (monadfin?) "./monadfin.scm"
%use (monad-arg monad-ret monad-ret/thunk monad-replicate-multiple monad-handle-multiple) "./monad.scm"
%use (raisu) "./raisu.scm"
%use (catch-any) "./catch-any.scm"
%use (cons!) "./cons-bang.scm"

(define (monad-except)
  (let ((exceptions '()))
    (lambda (monad-input)
      (if (monadfin? monad-input)
          (monad-ret monad-input
                     (if (null? exceptions)
                         (monad-arg monad-input)
                         (apply raisu 'except-monad exceptions)))
          (if (or (null? exceptions)
                  (memq 'always (monadstate-qtags monad-input)))
              (monad-ret/thunk
               monad-input
               (catch-any
                (lambda _
                  (call-with-values
                      (lambda _ ((monadstate-lval monad-input)))
                    (lambda vals
                      (lambda _ (apply values vals)))))
                (lambda args
                  (cons! args exceptions)
                  (lambda _ (raisu 'monad-except-default)))))
              (monad-ret/thunk
               monad-input
               (lambda _ (raisu 'monad-except-default))))))))
