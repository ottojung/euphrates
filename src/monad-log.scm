
%run guile

%var monad-log

%use (monadarg-qval monadarg-qvar) "./monadarg.scm"
%use (monadfin?) "./monadfin.scm"
%use (monad-arg) "./monad.scm"
%use (dprint) "./dprint.scm"

(define monad-log
  (lambda (monad-input)
    (if (monadfin? monad-input)
        (dprint "(return ~a)\n" (monad-arg monad-input))
        (dprint "(~a = ~a = ~a)\n"
                (monadarg-qvar monad-input)
                (monad-arg monad-input)
                (monadarg-qval monad-input)))
    monad-input))
