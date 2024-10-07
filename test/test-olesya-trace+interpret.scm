
(define (test-case program expected-value expected-trace)
  (define actual
    (olesya:trace+interpret program))

  (define actual-value
    (olesya:traced-object:value actual))
  (define actual-trace
    (olesya:traced-object:trace actual))

  (unless (equal? actual-value expected-value)
    (debugs actual-value))

  (unless (equal? actual-trace expected-trace)
    (debugs actual-trace))

  (assert= actual-value expected-value)
  (assert= actual-trace expected-trace)
  )





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

    tr-res

    )

 '(term (if (P) (R)))

 '(map (map (map (rule P (if (Q) (R)))
                 (map (rule Q (if (P) (R)))
                      (rule (term (if P Q)) (rule (term P) (term Q)))))
            (map (map (map (rule P (if (P) (Q)))
                           (map (rule Q (if (if (Q) (R)) (if (P) (R))))
                                (rule (term (if P Q)) (rule (term P) (term Q)))))
                      (map (rule P (P))
                           (map (rule Q (Q))
                                (map (rule R (R))
                                     (term (if (if P Q)
                                               (if (if Q R) (if P R))))))))
                 (term (if (P) (Q)))))
       (term (if (Q) (R)))))


(test-case
 ;;
 ;; Eval test.
 ;;

 '(begin

    (define x3
      (term (triple (x) (y) (z))))

    (define test1
      (rule (term P) (map (rule (x) (y)) (term P))))

    (define result/text
      (map (map (rule P (triple (x) (y) (z))) test1)
           x3))

    (= result/text
       (map (rule (x) (y)) (term (triple (x) (y) (z)))))

    (define result
      (eval result/text))

    (= result
       (term (triple (y) (y) (z))))

    result

    )

 '(term (triple (y) (y) (z)))

 '(eval (map (map (rule P (triple (x) (y) (z)))
                  (rule (term P) (map (rule (x) (y)) (term P))))
             (term (triple (x) (y) (z))))))

(test-case

 '(eval (map (map (rule P (triple (x) (y) (z)))
                  (rule (term P) (map (rule (x) (y)) (term P))))
             (term (triple (x) (y) (z)))))

 '(term (triple (y) (y) (z)))

 '(eval (map (map (rule P (triple (x) (y) (z)))
                  (rule (term P) (map (rule (x) (y)) (term P))))
             (term (triple (x) (y) (z))))))


(test-case

 '(begin

    (define x
      (term (if (P) (Q))))

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

    ;; (define thm2
    ;;   (let ((x1 (term (P)))) ;; -> (rule (term (P)) (term (P)))

    ;;     (map rule-x x1)
    ;;     ;; -> (rule (rule (term (P)) (term (P)))
    ;;     ;;          (rule (term (P)) (term (Q))))

    ;;     0))

    ;; (define thm3
    ;;   (let ((x1 (term P)))   ;; -> (rule (term P) (term P))

    ;;     (map (rule P Q) x1)
    ;;     ;; -> (rule (rule (term P) (term P))
    ;;     ;;          (rule (term P) (term Q)))

    ;;     0))

    rule-x)

 '(rule (term (P)) (term (Q)))

 '(map (map (rule Q (Q))
            (map (rule P (P))
                 (rule (term (if P Q)) (rule (term P) (term Q)))))
       (term (if (P) (Q)))))
