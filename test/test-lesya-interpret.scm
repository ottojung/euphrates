
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
 ;;
 ;; Basic proof.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 6.
 ;;

 '(begin

    (define x
      (axiom (if (P) (Q))))
    (define y
      (axiom (if (Q) (R))))

    (define z
      (lambda (p (P))
        (define v1 (apply x p))
        (define v2 (apply y v1))
        v2)))

 `((x (if (P) (Q)))
   (z (if (P) (R)))
   (y (if (Q) (R)))))


(test-case
 ;;
 ;; Basic proof.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 6.
 ;;

 '(begin

    (define y
      (axiom (if (P) (if (Q) (R)))))

    (define z
      (lambda (q (Q))
        (define k
          (lambda (p (P))
            (define v1 (apply y p))
            (define v2 (apply v1 q))
            v2))
        k)))

 `((z (if (Q) (if (P) (R))))
   (y (if (P) (if (Q) (R))))))
