
%run guile

%use (reversed-args-f) "./reversed-args-f.scm"

%var partial-apply1

(define-syntax partial-apply1-helper
  (syntax-rules ()
    ((_ f buf () last) (reversed-args-f f last . buf))
    ((_ f buf (a . args) last)
     (partial-apply1-helper f (a . buf) args last))))
(define-syntax-rule (partial-apply1 f . args)
  (lambda (x)
    (partial-apply1-helper f () args x)))
