
%run guile

%var monadic-bare
%var monadic

%use (memconst) "./memconst.scm"
%use (monadarg monadarg-cont monadarg-lval) "./monadarg.scm"
%use (monadfin monadfin-lval) "./monadfin.scm"
%use (monadic-global/p) "./monadic-global-p.scm"
%use (raisu) "./raisu.scm"

(define-syntax monadic-bare-handle-tags
  (syntax-rules ()
    ((monadic-bare-handle-tags ())
     (list))
    ((monadic-bare-handle-tags . tags)
     (list . tags))))

(define (rethunkify m)
  (define thunk (monadarg-lval m))
  thunk)

(define (rethunkify-list thunk)
  (cond
   ((list? thunk) thunk)
   ((procedure? thunk)
    (let ((lst (thunk)))
      (map (lambda (x) (lambda _ x)) lst)))
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
             (lambda (args) (apply values args))
             (quote (a . as))
             (quote b)
             (monadic-bare-handle-tags . tags))))
       (lambda (m)
         ((monadarg-cont m) (rethunkify-list (monadarg-lval m))))))
    ((_ f ((a . as) b . tags) . bodies)
     (call-with-values
         (lambda _
           (f (monadarg
               (memconst (call-with-values (lambda _ b) (lambda x x)))
               (lambda (k)
                 (apply
                  (lambda (a . as)
                    (monadic-bare-helper f . bodies))
                  k))
               (quote (a . as))
               (quote b)
               (monadic-bare-handle-tags . tags))))
       (lambda (m)
         ((monadarg-cont m) (rethunkify-list (monadarg-lval m))))))
    ((_ f (a b . tags) . ())
     (call-with-values
         (lambda _
           (f (monadarg
               (memconst b)
               identity
               (quote a)
               (quote b)
               (monadic-bare-handle-tags . tags))))
       (lambda (m)
         ((monadarg-cont m) (rethunkify m)))))
    ((_ f (a b . tags) . bodies)
     (call-with-values
         (lambda _
           (f (monadarg
               (memconst b)
               (lambda (a) (monadic-bare-helper f . bodies))
               (quote a)
               (quote b)
               (monadic-bare-handle-tags . tags))))
       (lambda (m)
         ((monadarg-cont m) (rethunkify m)))))))

(define-syntax monadic-bare
  (syntax-rules ()
    ((_ f0 . args)
     (let ((f f0))
       (call-with-values
           (lambda _
             (monadic-bare-helper f . args))
         (lambda results
           ((monadfin-lval
             (f (monadfin
                 (lambda _ (apply values (map (lambda (f) (f)) results)))))))))))))

;; NOTE: uses parameterization
(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (let* ((p (monadic-global/p))
            (f fexpr))
       (if p
           (monadic-bare (p f (quote fexpr)) . argv)
           (monadic-bare f . argv))))))
