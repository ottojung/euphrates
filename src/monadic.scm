
%run guile

%var monadic-bare
%var monadic

%use (memconst) "./memconst.scm"
%use (monadarg monadarg-cont monadarg-lval monadarg-qvar) "./monadarg.scm"
%use (monadfin monadfin-lval) "./monadfin.scm"
%use (monadic-global/p) "./monadic-global-p.scm"
%use (raisu) "./raisu.scm"
%use (range) "./range.scm"

(define-syntax monadic-bare-handle-tags
  (syntax-rules ()
    ((monadic-bare-handle-tags ())
     (list))
    ((monadic-bare-handle-tags . tags)
     (list . tags))))

(define (rethunkify-list m)
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

;; This is something like "do syntax" from Haskell
(define-syntax monadic-bare-helper
  (syntax-rules ()

    ((_ f ((a . as) b . tags) . ())
     (call-with-values
         (lambda _
           (f
            (monadarg
             (memconst (call-with-values (lambda _ b) (lambda x x)))
             (lambda args (apply values args))
             (quote (a . as))
             (quote b)
             (monadic-bare-handle-tags . tags))))
       (lambda (m)
         (apply (monadarg-cont m) (rethunkify-list m)))))

    ((_ f ((a . as) b . tags) . bodies)
     (call-with-values
         (lambda _
           (f (monadarg
               (memconst (call-with-values (lambda _ b) (lambda x x)))
               (lambda (a . as)
                 (monadic-bare-helper f . bodies))
               (quote (a . as))
               (quote b)
               (monadic-bare-handle-tags . tags))))
       (lambda (m)
         (apply (monadarg-cont m) (rethunkify-list m)))))

    ((_ f (a b . tags) . ())
     (call-with-values
         (lambda _
           (f (monadarg
               (memconst (list b))
               identity
               (quote a)
               (quote b)
               (monadic-bare-handle-tags . tags))))
       (lambda (m)
         (apply (monadarg-cont m) (rethunkify-list m)))))

    ((_ f (a b . tags) . bodies)
     (call-with-values
         (lambda _
           (f (monadarg
               (memconst (list b))
               (lambda (a) (monadic-bare-helper f . bodies))
               (quote a)
               (quote b)
               (monadic-bare-handle-tags . tags))))
       (lambda (m)
         (apply (monadarg-cont m) (rethunkify-list m)))))))

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
