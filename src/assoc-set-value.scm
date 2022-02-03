
%run guile

%var assoc-set-value!

(define (assoc-set-value! key value alist)
  (let loop ((alist alist))
    (if (null? alist)
        `((,key . ,value))
        (let ((x (car alist)))
          (if (equal? key (car x))
              (cons `(,key . ,value) (loop (cdr alist)))
              (cons x (cdr alist)))))))
