
%run guile

%var list-fold

(define-syntax-rule (list-fold (acc-name acc-value)
                               (i-name i-value)
                               . bodies)
  (let loop ((acc-name acc-value) (i-all i-value))
    (if (null? i-all) acc-name
        (let ((i-name (car i-all)))
          (let ((new-acc (begin . bodies)))
            (loop new-acc (cdr i-all)))))))
