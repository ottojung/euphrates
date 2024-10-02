

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
      (term (if (P) (Q))))
    (define y
      (term (if (Q) (R))))

    (define implication-reflexive
      (term (if P P)))
    (define implication-transitive
      (term (if (if P Q)
                (if (if Q R)
                    (if P R)))))

    (define promote
      (rule (term (if P Q))
            (rule (term P) (term Q))))

    (define promote-x
      (map (rule Q (Q))
           (map (rule P (P)) promote)))

    (= promote-x
       (rule (term (if (P) (Q)))
             (rule (term (P)) (term (Q)))))

    (define rule-x
      (map promote-x x))

    (= rule-x (rule (term (P)) (term (Q))))

    (define promote-y
      (map (rule P (Q))
           (map (rule Q (R)) promote)))

    (= promote-y
       (rule (term (if (Q) (R)))
             (rule (term (Q)) (term (R)))))

    (define rule-y
      (map promote-y y))

    (= rule-y (rule (term (Q)) (term (R))))

    (define refl-p
      (= (map (rule P (P)) implication-reflexive)
         (term (if (P) (P)))))

    (define tr
      (= (map (rule P (P))
              (map (rule Q (Q))
                   (map (rule R (R)) implication-transitive)))
         (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R)))))))

    (define tr-rule
      (= (map (rule P (if (P) (Q)))
              (map (rule Q (if (if (Q) (R)) (if (P) (R)))) promote))

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
      (= (map (rule P (if (Q) (R)))
              (map (rule Q (if (P) (R))) promote))
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


(test-case
 ;;
 ;; Basic proof, with some eval.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 6.
 ;;

 '(begin

    (define x
      (term (if (P) (Q))))
    (define y
      (term (if (Q) (R))))

    (define implication-reflexive
      (term (if P P)))
    (define implication-transitive
      (term (if (if P Q)
                (if (if Q R)
                    (if P R)))))

    (define promote
      (rule (term (if P Q))
            (rule (term P) (term Q))))

    (define promote-x
      (map (rule Q (Q))
           (map (rule P (P)) promote)))

    (= promote-x
       (rule (term (if (P) (Q)))
             (rule (term (P)) (term (Q)))))

    (define rule-x
      (map promote-x x))

    (= rule-x (rule (term (P)) (term (Q))))

    (define promote-y
      (map (rule P (Q))
           (map (rule Q (R)) promote)))

    (= promote-y
       (rule (term (if (Q) (R)))
             (rule (term (Q)) (term (R)))))

    (define rule-y
      (map promote-y y))

    (= rule-y (rule (term (Q)) (term (R))))

    (define refl-p
      (= (map (rule P (P)) implication-reflexive)
         (term (if (P) (P)))))

    (define tr
      (= (map (rule P (P))
              (map (rule Q (Q))
                   (map (rule R (R)) implication-transitive)))
         (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R)))))))

    (define tr-rule
      (= (map (rule P (if (P) (Q)))
              (map (rule Q (if (if (Q) (R)) (if (P) (R)))) promote))

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
      (= (map (rule P (if (Q) (R)))
              (map (rule Q (if (P) (R))) promote))
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
