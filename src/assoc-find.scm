
%run guile

%var assoc/find

(define (assoc/find predicate alist)
  (let loop ((alist alist))
    (if (null? alist) default
        (let* ((x (car alist))
               (k (car x)))
          (if (predicate k keys)
              x
              (loop (cdr alist)))))))


