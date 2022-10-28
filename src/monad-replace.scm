
%run guile

%var monad-replace

%use (monadstate-lval monadstate-qtags) "./monadstate.scm"
%use (monad-ret/thunk) "./monad.scm"

;; Replaces expressions by different ones based on associted tags
;; Can be used for deriving many less general monads, like lazy-monad or filter-monad
(define (monad-replace test/replace-procedure)
  (lambda (monad-input)
    (let ((tags (monadstate-qtags monad-input))
          (arg#lazy (monadstate-lval monad-input)))
      (monad-ret/thunk (test/replace-procedure tags arg#lazy)))))
