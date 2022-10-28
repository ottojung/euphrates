
%run guile

%var monad-log

%use (dprint) "./dprint.scm"
%use (monad-args) "./monad.scm"
%use (monadarg-qval monadarg-qvar) "./monadarg.scm"
%use (monadfin?) "./monadfin.scm"
%use (~a) "./tilda-a.scm"
%use (words->string) "./words-to-string.scm"

(define (monad-log-show-values monad-input)
  (words->string (map ~a (monad-args monad-input))))

(define monad-log
  (lambda (monad-input)
    (if (monadfin? monad-input)
        (dprint "(return ~a)\n" (monad-log-show-values monad-input))
        (dprint "(~a = ~a = ~a)\n"
                (monadarg-qvar monad-input)
                (monad-log-show-values monad-input)
                (monadarg-qval monad-input)))
    monad-input))
