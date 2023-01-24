
%run guile

%var syntax-map

%use (syntax-reverse) "./syntax-reverse.scm"

(define-syntax syntax-map/buf
  (syntax-rules ()
    ((_ cont buf fn) (syntax-reverse cont buf))
    ((_ cont buf (fn ctxarg) x . xs) (syntax-map/buf cont ((fn ctxarg x) . buf) (fn ctxarg) . xs))
    ((_ cont buf fn x . xs) (syntax-map/buf cont ((fn x) . buf) fn arg . xs))))

(define-syntax syntax-map
  (syntax-rules ()
    ((_ cont fn args-to-map)
     (syntax-map/buf cont () fn . args-to-map))))
