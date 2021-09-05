
%run guile

%var syntax-map

%use (reverse-syntax-f) "./reverse-syntax-f.scm"

(define-syntax syntax-map/buf
  (syntax-rules ()
    ((_ cont cont-arg buf fn arg) (reverse-syntax-f cont cont-arg buf))
    ((_ cont cont-arg buf fn arg x . xs) (syntax-map/buf cont cont-arg ((fn arg x) . buf) fn arg . xs))))

(define-syntax syntax-map
  (syntax-rules ()
    ((_ cont cont-arg fn arg args-to-map)
     (syntax-map/buf cont cont-arg () fn arg . args-to-map))))
