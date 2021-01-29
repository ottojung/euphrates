
%run guile

%var list-fold*

(define-syntax-rule (list-fold* (acc-name acc-value)
                                (x-name xs-name i-value)
                                . bodies)
  (let loop ((acc-name acc-value)
             (i-all i-value))
    (if (null? i-all) acc-name
        (let ((x-name (car i-all))
              (xs-name (cdr i-all)))
          (define-values (new-acc rest) (begin . bodies))
          (loop new-acc rest)))))
