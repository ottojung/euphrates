
%run guile

%var monadic-bare
%var monadic

%use (identity*) "./identity-star.scm"
%use (memconst) "./memconst.scm"
%use (monad-current-arg/p) "./monad-current-arg-p.scm"
%use (monadarg-cont monadarg-lval monadarg-make-empty monadarg-qvar set-monadarg-cont! set-monadarg-lval! set-monadarg-qtags! set-monadarg-qval! set-monadarg-qvar!) "./monadarg.scm"
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
     (let ((arg (monad-current-arg/p)))
       (set-monadarg-lval! arg (memconst (call-with-values (lambda _ val) list)))
       (set-monadarg-cont! arg cont)
       (set-monadarg-qvar! arg (quote var))
       (set-monadarg-qval! arg (quote val))
       (set-monadarg-qtags! arg (list . tags))
       (monadic-bare-continue (f arg))))))

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
       (parameterize ((monad-current-arg/p (monadarg-make-empty)))
         (monadic-bare m . argv))))))
