


(define (assq-set-value key value alist0)
  (let loop ((alist alist0))
    (if (null? alist)
        `((,key . ,value))
        (let ((x (car alist)))
          (if (eq? key (car x))
              (cons `(,key . ,value) (cdr alist))
              (cons x (loop (cdr alist))))))))
