
%run guile

%var syntax-append

%use (reversed-args) "./reversed-args.scm"

(define-syntax syntax-append/buf
  (syntax-rules ()
    ((_ buf () ()) (reversed-args . buf))
    ((_ buf (a . as) bs)
     (syntax-append/buf (a . buf) as bs))
    ((_ buf as (b . bs))
     (syntax-append/buf (b . buf) as bs))))

(define-syntax syntax-append
  (syntax-rules ()
    ((_ a b) (syntax-append/buf () a b))))
