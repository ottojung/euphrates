
%run guile

%use (memconst) "./memconst.scm"
%use (replicate) "./replicate.scm"

%var monad-arg#lazy
%var monad-arg
%var monad-cont
%var monad-qvar
%var monad-qval
%var monad-qtags
%var monad-last?
%var monad-cret
%var monad-ret
%var monad-ret-id

(define (monad-last? monad-input)
  (list-ref monad-input 0))
(define (monad-arg#lazy monad-input)
  (list-ref monad-input 1))
(define (monad-arg monad-input)
  ((monad-arg#lazy monad-input))) ;; NOTE: evaluates it right away
(define (monad-cont monad-input)
  (list-ref monad-input 2))
(define (monad-qvar monad-input)
  (list-ref monad-input 3))
(define (monad-qval monad-input)
  (list-ref monad-input 4))
(define (monad-qtags monad-input)
  (list-ref monad-input 5))

(define-syntax monad-cret
  (syntax-rules ()
    ((_ monad-input arg cont)
     (values (monad-last? monad-input)
             (memconst arg)
             cont
             (monad-qvar monad-input)
             (monad-qval monad-input)
             (monad-qtags monad-input)))))

(define-syntax monad-ret
  (syntax-rules ()
    ((_ monad-input arg)
     (values (monad-last? monad-input)
             (memconst arg)
             (monad-cont monad-input)
             (monad-qvar monad-input)
             (monad-qval monad-input)
             (monad-qtags monad-input)))))

(define-syntax monad-ret-id
  (syntax-rules ()
    ((_ monad-input)
     (apply values monad-input))))

(define (monad-handle-multiple monad-input arg)
  (let* ((qvar (monad-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (replicate len (arg)))))

(define (monad-replicate-multiple monad-input arg)
  (let* ((qvar (monad-qvar monad-input))
         (len (if (list? qvar) (length qvar) 1)))
    (if (< len 2)
        arg
        (replicate len arg))))
