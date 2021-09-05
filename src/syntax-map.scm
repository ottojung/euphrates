
%run guile

%var syntax-map

%use (syntax-reverse) "./syntax-reverse.scm"

(define-syntax syntax-map/buf
  (syntax-rules ()
    ((_ cont buf fn arg) (syntax-reverse cont buf))
    ((_ cont buf fn arg x . xs) (syntax-map/buf cont ((fn arg x) . buf) fn arg . xs))))

(define-syntax syntax-map
  (syntax-rules ()
    ((_ cont fn arg args-to-map)
     (syntax-map/buf cont () fn arg . args-to-map))))
