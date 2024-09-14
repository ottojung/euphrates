
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

    (when x (if (P) (Q)))
    (when y (if (Q) (R)))

    (define z
      (suppose (p (P))
               (define v1 (app x p))
               (define v2 (app y v1))
               v2)))

 '((z (if (P) (R)))))


(test-case
 ;;
 ;; Basic proof.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 6.
 ;;

 '(begin

    (when x (if (P) (if (Q) (R))))

    (define z
      (suppose (q (Q))
               (define k
                 (suppose (p (P))
                          (define v1 (app x p))
                          (define v2 (app y q))
                          v2))
               k)))

 '((z (if (Q) (if (P) (R))))))
