
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
    ((_ (f var val tags) arg cont)
     (monadic-bare-continue
      (f
       (monadarg
        (memconst arg)
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
      (call-with-values (lambda _ y) list)
      identity*))

    ((_ f ((x . xs) y . tags) . bodies)
     (monadic-bare-single
      (f (x . xs) y tags)
      (call-with-values (lambda _ y) list)
      (lambda (x . xs) (monadic-bare-helper f . bodies))))

    ((_ f (x y . tags) . ())
     (monadic-bare-single
      (f x y tags)
      (list y)
      identity))

    ((_ f (x y . tags) . bodies)
     (monadic-bare-single
      (f x y tags)
      (list y)
      (lambda (x) (monadic-bare-helper f . bodies))))))

(define-syntax monadic-bare
  (syntax-rules ()
    ((_ f0 . args)
     (apply
      values
      (let ((f f0))
        (call-with-values
            (lambda _
              (monadic-bare-helper f . args))
          (lambda results
            ((monadfin-lval
              (f (monadfin
                  (lambda _ (map (lambda (f) (f)) results)))))))))))))

;; NOTE: uses parameterization
(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (let* ((p (monadic-global/p))
            (f fexpr))
       (if p
           (monadic-bare (p f (quote fexpr)) . argv)
           (monadic-bare f . argv))))))
