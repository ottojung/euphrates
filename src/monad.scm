
%run guile

%var monad-cret
%var monad-cret/thunk
%var monad-ret
%var monad-ret/thunk
%var monad-arg
%var monad-args
%var monad-replicate-multiple
%var monad-handle-multiple

%use (memconst) "./memconst.scm"
%use (monadarg monadarg-cont monadarg-lval monadarg-qtags monadarg-qval monadarg-qvar monadarg?) "./monadarg.scm"
%use (monadfin monadfin-lval monadfin?) "./monadfin.scm"
%use (raisu) "./raisu.scm"
%use (replicate) "./replicate.scm"

(define (monad-args monad-input)
  (if (monadarg? monad-input)
      ((monadarg-lval monad-input))
      ((monadfin-lval monad-input))))

(define (monad-arg monad-input)
  (apply values (monad-args monad-input)))

(define-syntax monad-cret
  (syntax-rules ()
    ((_ monad-input arg cont)
     (begin
       (unless (list? arg)
         (raisu 'monad-lval-must-be-list arg))

       (if (monadarg? monad-input)
           (monadarg (memconst arg)
                     cont
                     (monadarg-qvar monad-input)
                     (monadarg-qval monad-input)
                     (monadarg-qtags monad-input))
           (monadfin
            (memconst
              (call-with-values
                  (lambda _ (cont arg))
                (lambda vals vals)))))))))

(define-syntax monad-cret/thunk
  (syntax-rules ()
    ((_ monad-input arg cont)
     (begin
       (unless (list? arg)
         (raisu 'monad-lval-must-be-list arg))

       (if (monadarg? monad-input)
           (monadarg arg
                     cont
                     (monadarg-qvar monad-input)
                     (monadarg-qval monad-input)
                     (monadarg-qtags monad-input))
           (monadfin
            (memconst
              (call-with-values
                  (lambda _ (cont arg))
                (lambda vals vals)))))))))

(define-syntax monad-ret
  (syntax-rules ()
    ((_ monad-input arg)
     (begin
       (unless (list? arg)
         (raisu 'monad-lval-must-be-list arg))

       (if (monadfin? monad-input)
           (monadfin (lambda _ arg))
           (monadarg (memconst arg)
                     (monadarg-cont monad-input)
                     (monadarg-qvar monad-input)
                     (monadarg-qval monad-input)
                     (monadarg-qtags monad-input)))))))

(define-syntax monad-ret/thunk
  (syntax-rules ()
    ((_ monad-input arg)
     (if (monadfin? monad-input)
         (monadfin arg)
         (monadarg arg
                   (monadarg-cont monad-input)
                   (monadarg-qvar monad-input)
                   (monadarg-qval monad-input)
                   (monadarg-qtags monad-input))))))

(define (monad-handle-multiple monad-input arg)
  (if (monadfin? monad-input)
      (arg)
      (let* ((qvar (monadarg-qvar monad-input))
             (len (if (list? qvar) (length qvar) 1)))
        (if (< len 2)
            arg
            (replicate len (arg))))))

(define (monad-replicate-multiple monad-input arg)
  (let* ((qvar (monadarg-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (replicate len arg))))
