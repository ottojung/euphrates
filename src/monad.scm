
%run guile

%var monad-cret
%var monad-ret
%var monad-arg
%var monad-replicate-multiple
%var monad-handle-multiple

%use (memconst) "./memconst.scm"
%use (replicate) "./replicate.scm"
%use (define-type9) "./define-type9.scm"

%use (monadarg monadarg? monadarg-lval monadarg-cont monadarg-qvar monadarg-qval monadarg-qtags) "./monadarg.scm"
%use (monadfin monadfin? monadfin-lval) "./monadfin.scm"

(define (monad-arg monad-input)
  (if (monadarg? monad-input)
      ((monadarg-lval monad-input))
      ((monadfin-lval monad-input))))

(define-syntax monad-cret
  (syntax-rules ()
    ((_ monad-input arg cont)
     (if (monadarg? monad-input)
         (monadarg (memconst arg)
                   cont
                   (monadarg-qvar monad-input)
                   (monadarg-qval monad-input)
                   (monadarg-qtags monad-input))
         (monadfin (lambda _ (cont arg)))))))

(define-syntax monad-ret
  (syntax-rules ()
    ((_ monad-input arg)
     (if (monadfin? monad-input)
         (monadfin (lambda _ arg))
         (monadarg (memconst arg)
                   (monadarg-cont monad-input)
                   (monadarg-qvar monad-input)
                   (monadarg-qval monad-input)
                   (monadarg-qtags monad-input))))))

(define (monad-handle-multiple monad-input arg)
  (let* ((qvar (monadarg-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (replicate len (arg)))))

(define (monad-replicate-multiple monad-input arg)
  (let* ((qvar (monadarg-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (replicate len arg))))
