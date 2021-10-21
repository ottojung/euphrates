
%run guile

%var monad-lazy

%use (monadarg-qvar monadarg-qtags monadarg-lval) "./monadarg.scm"
%use (monad-arg monad-ret) "./monad.scm"
%use (monadfin?) "./monadfin.scm"
%use (dynamic-thread-async) "./dynamic-thread-async.scm"
%use (range) "./range.scm"
%use (memconst) "./memconst.scm"

;; Provides optimistic evaluation
(define monad-lazy
  (lambda (monad-input)
    (if (monadfin? monad-input) monad-input
        (let* ((qvar (monadarg-qvar monad-input))
               (len (if (list? qvar) (length qvar) 1))
               (single? (< len 2))
               (result
                (if (memq 'async (monadarg-qtags monad-input))
                    (dynamic-thread-async (monad-arg monad-input))
                    (monadarg-lval monad-input)))
               (choose
                (lambda (i)
                  (memconst
                   (list-ref (result) i))))
               (return
                (if single? result
                    (map choose (range len)))))
          (monad-ret monad-input return)))))
