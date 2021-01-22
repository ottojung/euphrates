
%run guile

%use (reversed-args-f) "./reversed-args-f.scm"

%var partial-apply

(define-syntax partial-apply-helper
  (syntax-rules ()
    ((_ f buf () last) (apply f (reversed-args-f cons* last . buf)))
    ((_ f buf (a . args) last)
     (partial-apply-helper f (a . buf) args last))))
(define-syntax-rule (partial-apply f . args)
  (lambda xs
    (partial-apply-helper f () args xs)))
