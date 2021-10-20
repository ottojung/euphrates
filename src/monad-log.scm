
%run guile

%var monad-log

%use (monad-qval monad-qvar monad-arg monad-last? monad-ret-id) "./monad.scm"
%use (dprint) "./dprint.scm"

(define monad-log
  (lambda monad-input
    (if (monad-last? monad-input)
        (dprint "(return ~a)\n" (monad-arg monad-input))
        (dprint "(~a = ~a = ~a)\n"
                (monad-qvar monad-input)
                (monad-arg monad-input)
                (monad-qval monad-input)))
    (monad-ret-id monad-input)))
