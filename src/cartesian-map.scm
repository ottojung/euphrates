
%run guile

%var cartesian-map

(define (cartesian-map function a b)
  (let lp1 ((ai a))
    (if (null? ai) (list)
        (let ((av (car ai)))
          (let lp2 ((bi b))
            (if (null? bi)
                (lp1 (cdr ai))
                (cons (function av (car bi))
                      (lp2 (cdr bi)))))))))

