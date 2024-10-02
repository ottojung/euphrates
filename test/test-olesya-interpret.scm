

(define (test-case program expected-mapping)
  (define result/wrapped
    (olesya:interpret program))

  (define-values (type result)
    (values (car result/wrapped) (cdr result/wrapped)))

  (define (print-actual)
    (debugs result/wrapped)
    (exit 1))

  (define actual
    (cond
     ((equal? expected-mapping 'ignore-ok)
      (unless (equal? type 'ok)
        (print-actual))
      (assert= type 'ok)
      #f)
     ((equal? expected-mapping 'ignore-error)
      (unless (equal? type 'error)
        (print-actual))
      (assert= type 'error)
      #f)
     ((equal? type 'error)
      result/wrapped)
     ((equal? type 'ok)
      result/wrapped)
     (else
      (raisu-fmt 'unknown-type "Unknown type of result: ~s" type))))

  (when actual
    (unless (equal? actual expected-mapping)
      (print-actual))
    (assert= actual expected-mapping)))





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
      (axiom (term (if (P) (Q)))))
    (define y
      (axiom (term (if (Q) (R)))))

    (define implication-reflexive
      (axiom (term (if P P))))
    (define implication-transitive
      (axiom (term (if (if P Q)
                       (if (if Q R)
                           (if P R))))))

    (define promote
      (axiom (rule (term (if P Q))
                   (rule (term P) (term Q)))))

    (define promote-x
      (map (specify Q (Q))
           (map (specify P (P)) promote)))

    (= promote-x
       (rule (term (if (P) (Q)))
             (rule (term (P)) (term (Q)))))

    (define rule-x
      (map promote-x x))

    (= rule-x (rule (term (P)) (term (Q))))

    (define promote-y
      (map (specify P (Q))
           (map (specify Q (R)) promote)))

    (= promote-y
       (rule (term (if (Q) (R)))
             (rule (term (Q)) (term (R)))))

    (define rule-y
      (map promote-y y))

    (= rule-y (rule (term (Q)) (term (R))))

    (define refl-p
      (= (map (specify P (P)) implication-reflexive)
         (term (if (P) (P)))))

    (define tr
      (= (map (specify P (P))
              (map (specify Q (Q))
                   (map (specify R (R)) implication-transitive)))
         (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R)))))))

    (define tr-rule
      (= (map (specify P (if (P) (Q)))
              (map (specify Q (if (if (Q) (R)) (if (P) (R)))) promote))

         (rule (term (if (if (P) (Q))
                         (if (if (Q) (R))
                             (if (P) (R)))))

               (rule (term (if (P) (Q)))
                     (term (if (if (Q) (R))
                               (if (P) (R))))))))

    (define tr1
      (= (map tr-rule tr)
          (rule (term (if (P) (Q)))
                (term (if (if (Q) (R)) (if (P) (R)))))))

    (define tr2
      (= (map tr1 x)
         (term (if (if (Q) (R)) (if (P) (R))))))

    (define prom-tr2
      (= (map (specify P (if (Q) (R)))
              (map (specify Q (if (P) (R))) promote))
         (rule (term (if (if (Q) (R)) (if (P) (R))))
               (rule (term (if (Q) (R))) (term (if (P) (R)))))))

    (define tr2-rule
      (= (map prom-tr2 tr2)
         (rule (term (if (Q) (R))) (term (if (P) (R))))))

    (define tr-res
      (= (map tr2-rule y)
         (term (if (P) (R)))))

    )

 `ignore-ok)
