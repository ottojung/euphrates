
%run guile

%var reverse-syntax-f

(define-syntax reverse-syntax-f-buf
  (syntax-rules ()
    ((_ f (x . xs) buf)
     (reverse-syntax-f-buf f xs (x . buf)))
    ((_ f () buf)
     (f buf))))
(define-syntax reverse-syntax-f-arg-buf
  (syntax-rules ()
    ((_ f arg (x . xs) buf)
     (reverse-syntax-f-arg-buf f arg xs (x . buf)))
    ((_ f arg () buf)
     (f arg buf))))

(define-syntax reverse-syntax-f
  (syntax-rules ()
    ((_ f lst)
     (reverse-syntax-f-buf f lst ()))
    ((_ f f-arg lst)
     (reverse-syntax-f-arg-buf f f-arg lst ()))))



