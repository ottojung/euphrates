



(define-syntax assoc/find
  (syntax-rules ()
    ((_ predicate alist)
     (assoc-find predicate alist (raisu 'could-not-find-the-element alist)))
    ((_ predicate0 alist default)
     (let ((predicate predicate0))
       (let loop ((alist alist))
         (if (null? alist) default
             (let* ((x (car alist))
                    (k (car x)))
               (if (predicate k)
                   x
                   (loop (cdr alist))))))))))


