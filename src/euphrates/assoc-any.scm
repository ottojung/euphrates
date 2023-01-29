
%run guile

%var assoc/any

(define (assoc/any keys alist)
  (let loop ((alist alist))
    (if (null? alist) #f
        (let* ((x (car alist))
               (k (car x)))
          (if (member k keys)
              x
              (loop (cdr alist)))))))
