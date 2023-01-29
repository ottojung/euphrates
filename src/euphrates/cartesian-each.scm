
%run guile

%var cartesian-each

(define (cartesian-each function a b)
  (let lp ((ai a))
    (unless (null? ai)
      (let ((av (car ai)))
        (let lp ((bi b))
          (unless (null? bi)
            (function av (car bi))
            (lp (cdr bi)))))
      (lp (cdr ai)))))
