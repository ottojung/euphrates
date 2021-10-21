
%run guile

%var monadic-bare
%var monadic

%use (memconst) "./memconst.scm"
%use (monadic-global/p) "./monadic-global-p.scm"

(define-syntax monadic-bare-handle-tags
  (syntax-rules ()
    ((monadic-bare-handle-tags ())
     (list))
    ((monadic-bare-handle-tags . tags)
     (list . tags))))

;; This is something like "do syntax" from Haskell
(define-syntax monadic-bare-helper
  (syntax-rules ()
    ((_ f ((a . as) b . tags) . ())
     (call-with-values
         (lambda _
           (f #f
              (memconst (call-with-values (lambda _ b) (lambda x x)))
              (lambda args (apply values args))
              (quote (a . as))
              (quote b)
              (monadic-bare-handle-tags . tags)))
       (lambda (last? r-x r-cont qvar qval qtags)
         (r-cont (r-x)))))
    ((_ f ((a . as) b . tags) . bodies)
     (call-with-values
         (lambda _
           (f #f
              (memconst (call-with-values (lambda _ b) (lambda x x)))
              (lambda (k)
                (apply
                 (lambda (a . as)
                   (monadic-bare-helper f . bodies))
                 k))
              (quote (a . as))
              (quote b)
              (monadic-bare-handle-tags . tags)))
       (lambda (last? r-x r-cont qvar qval qtags)
         (r-cont (r-x)))))
    ((_ f (a b . tags) . ())
     (call-with-values
         (lambda _
           (f #f
              (memconst b)
              identity
              (quote a)
              (quote b)
              (monadic-bare-handle-tags . tags)))
       (lambda (last? r-x r-cont qvar qval qtags)
         (r-cont (r-x)))))
    ((_ f (a b . tags) . bodies)
     (call-with-values
         (lambda _
           (f #f
              (memconst b)
              (lambda (a)
                (monadic-bare-helper f . bodies))
              (quote a)
              (quote b)
              (monadic-bare-handle-tags . tags)))
       (lambda (last? r-x r-cont qvar qval qtags)
         (r-cont (r-x)))))))

(define-syntax monadic-bare
  (syntax-rules ()
    ((_ f0 . args)
     (let ((f f0))
       (call-with-values
           (lambda _
             (monadic-bare-helper f . args))
         (lambda results
           (call-with-values
               (lambda _
                 (f #t
                    (lambda _ (apply values results))
                    (lambda as (apply values as))
                    #f
                    #f
                    '()))
             (lambda (last? r-x r-cont qvar qval qtags)
               (r-cont (r-x))))))))))

;; NOTE: uses parameterization
(define-syntax monadic
  (syntax-rules ()
    ((_ fexpr . argv)
     (let* ((p (monadic-global/p))
            (f fexpr))
       (if p
           (monadic-bare (p f (quote fexpr)) . argv)
           (monadic-bare f . argv))))))
