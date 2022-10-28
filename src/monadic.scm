
%run guile

%var monadic-bare
%var monadic

%use (identity*) "./identity-star.scm"
%use (memconst) "./memconst.scm"
%use (monadarg monadarg-cont monadarg-lval monadarg-qvar) "./monadarg.scm"
%use (monadfin monadfin-lval) "./monadfin.scm"
%use (monadic-global/p) "./monadic-global-p.scm"
%use (raisu) "./raisu.scm"
%use (range) "./range.scm"

(define (monadic-bare-rethunkify m)
  (define thunk (monadarg-lval m))
  (define qvar (monadarg-qvar m))
  (define len (if (list? qvar) (length qvar) 1))

  (cond
   ((list? thunk) thunk)
   ((procedure? thunk)
    (let ((result (memconst (thunk))))
      (map
       (lambda (i)
         (memconst
          (list-ref (result) i)))
       (range len))))
   (else
    (raisu 'bad-thunk-type thunk))))

(define (monadic-bare-continue m)
  (apply (monadarg-cont m) (monadic-bare-rethunkify m)))

(define-syntax monadic-bare-single
  (syntax-rules ()
    ((_ (f var val tags) cont)
     (monadic-bare-continue
      (f
       (monadarg
        (memconst (call-with-values (lambda _ val) list))
        cont
        (quote var)
        (quote val)
        (list . tags)))))))

;; This is something like "do syntax" from Haskell
(define-syntax monadic-bare-helper
  (syntax-rules ()

    ((_ f ((x . xs) y . tags) . ())
     (monadic-bare-single
      (f (x . xs) y tags)
      identity*))

    ((_ f ((x . xs) y . tags) . bodies)
     (monadic-bare-single
      (f (x . xs) y tags)
      (lambda (x . xs) (monadic-bare-helper f . bodies))))

    ((_ f (x y . tags) . ())
     (monadic-bare-single
      (f x y tags)
      identity))

    ((_ f (x y . tags) . bodies)
     (monadic-bare-single
      (f x y tags)
      (lambda (x) (monadic-bare-helper f . bodies))))))

(define-syntax monadic-bare
  (syntax-rules ()
    ((_ m . args)
     (apply
      values
      (call-with-values
          (lambda _
            (monadic-bare-helper m . args))
        (lambda results
          ((monadfin-lval
            (m (monadfin
                (lambda _ (map (lambda (f) (f)) results))))))))))))

;; NOTE: uses parameterization
(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (let* ((p (monadic-global/p))
            (f fexpr)
            (m (if p (p f (quote fexpr)) f)))
       (monadic-bare m . argv)))))
