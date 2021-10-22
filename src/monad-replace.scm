
%run guile

%var monad-replace

%use (monadarg-lval monadarg-qtags) "./monadarg.scm"
%use (monad-ret/thunk) "./monad.scm"

;; Replaces expressions by different ones based on associted tags
;; Can be used for deriving many less general monads, like lazy-monad or filter-monad
(define (monad-replace test/replace-procedure)
  (lambda (monad-input)
    (let ((tags (monadarg-qtags monad-input))
          (arg#lazy (monadarg-lval monad-input)))
      (monad-ret/thunk (test/replace-procedure tags arg#lazy)))))
