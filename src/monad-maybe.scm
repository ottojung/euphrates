
%run guile

%var monad-maybe

%use (monad-arg monad-cret monad-ret) "./monad.scm"

(define (monad-maybe predicate)
  (lambda monad-input
    (let ((arg (monad-arg monad-input)))
      (if (predicate arg)
          (monad-cret monad-input arg identity)
          (monad-ret  monad-input arg)))))
