
%run guile

;; Almost like racket's `for/list'
%var list-fold

(define-syntax list-fold
  (syntax-rules ()
    ((_ (acc-name acc-value)
        (i-name i-value)
        . bodies)
     (let loop ((acc-name acc-value) (i-all i-value))
       (if (null? i-all) acc-name
           (let ((i-name (car i-all)))
             (let ((new-acc (let () . bodies)))
               (loop new-acc (cdr i-all)))))))))
