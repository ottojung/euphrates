
%run guile

%var cartesian-any?

(define (cartesian-any? predicate a b)
  (let lp ((ai a))
    (if (null? ai) #f
        (or (let ((av (car ai)))
              (let lp ((bi b))
                (if (null? bi) #f
                    (or (predicate av (car bi))
                        (lp (cdr bi))))))
            (lp (cdr ai))))))
