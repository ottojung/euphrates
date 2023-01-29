
(cond-expand
 (guile
  (define-module (euphrates list-fold)
    :export (list-fold))))

;; Almost like racket's `for/list'

(define-syntax list-fold
  (syntax-rules ()
    ((_ ((acc-x . acc-xs) acc-value)
        (i-name i-value)
        . bodies)
     (let loop ((acc-list (call-with-values (lambda _ acc-value) (lambda x x)))
                (i-all i-value))
       (if (null? i-all) (apply values acc-list)
           (let ((i-name (car i-all)))
             (call-with-values
                 (lambda _ (apply values acc-list))
               (lambda (acc-x . acc-xs)
                 (call-with-values (lambda _ . bodies)
                   (lambda new-acc
                     (loop new-acc (cdr i-all))))))))))
    ((_ (acc-name acc-value)
        (i-name i-value)
        . bodies)
     (let loop ((acc-name acc-value) (i-all i-value))
       (if (null? i-all) acc-name
           (let ((i-name (car i-all)))
             (let ((new-acc (let () . bodies)))
               (loop new-acc (cdr i-all)))))))))
