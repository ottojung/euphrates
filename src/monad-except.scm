
%run guile

%var monad-except

%use (monadarg-lval monadarg-qtags) "./monadarg.scm"
%use (monadfin?) "./monadfin.scm"
%use (monad-arg monad-ret monad-replicate-multiple monad-handle-multiple) "./monad.scm"
%use (raisu) "./raisu.scm"
%use (catch-any) "./catch-any.scm"
%use (cons!) "./cons-bang.scm"

(define (monad-except)
  (let ((exceptions (list)))
    (lambda (monad-input)
      (if (monadfin? monad-input)
          (monad-ret monad-input
                     (monad-handle-multiple
                      monad-input
                      (if (null? exceptions)
                          (monad-arg monad-input)
                          (apply raisu 'except-monad exceptions))))
          (if (or (null? exceptions)
                  (memq 'always (monadarg-qtags monad-input)))
              (monad-ret monad-input
                         (catch-any
                          (monadarg-lval monad-input)
                          (lambda args
                            (cons! args exceptions)
                            (monad-replicate-multiple
                             monad-input
                             'monad-except-default))))
              (monad-ret monad-input
                         (monad-handle-multiple
                          monad-input
                          'monad-except-default)))))))
