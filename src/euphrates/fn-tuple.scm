
%run guile

%var fn-tuple

%use (raisu) "./raisu.scm"

(define (fn-tuple . funcs)
  (if (null? funcs)
      (raisu 'null-funcs-to-fn-tuple)
      (lambda (lst)
        (map (lambda (f tuple-element) (f tuple-element)) funcs lst))))
