
(define-syntax test-case
  (syntax-rules ()
    ((_ program expected-mapping)
     (let ()
       (define program* program)
       (define expected-mapping* expected-mapping)

       (define result
         (lesya:interpret program*))

       (define actual
         (map (lambda (p) (list (car p) (cdr p)))
              (hashmap->alist result)))

       (unless (equal? actual expected-mapping*)
         (debugs actual)
         (exit 1))

       (assert= actual expected-mapping*)))))





;;;;;;;;;;;;;;;;;;;
;;
;;  Test cases:
;;




(test-case

 '(begin

    (when x (if (pair? P) (pair? Q)))
    (when y (if (pair? Q) (pair? R)))

    (cons z
          (suppose (m (pair? M))
                   (cons refl1 (set (m M) P))
                   (cons v1 (app x refl1))
                   (cons v2 (app y v1))
                   v2))

    0)

 '((z (if (pair? M) (pair? R)))))
