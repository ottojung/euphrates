
%run guile

%var syntax-append

%use (reverse-syntax-f) "./reverse-syntax-f.scm"

(define-syntax syntax-append/buf
  (syntax-rules ()
    ((_ cont cont-arg buf () ()) (reverse-syntax-f cont cont-arg buf))
    ((_ cont cont-arg buf (a . as) bs)
     (syntax-append/buf cont cont-arg (a . buf) as bs))
    ((_ cont cont-arg buf as (b . bs))
     (syntax-append/buf cont cont-arg (b . buf) as bs))))

(define-syntax syntax-append
  (syntax-rules ()
    ((_ cont cont-arg a b) (syntax-append/buf cont cont-arg () a b))))
