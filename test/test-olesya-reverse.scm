
(define (test-case program expected)
  (define actual
    (olesya:reverse program))

  (unless (equal? actual expected)
    (debugs (list 'quote actual)))

  (assert= actual expected)

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

 '((term (if (P) (Q)))
   (term (if (Q) (R)))
   (term (if P P))
   (term (if (if P Q) (if (if Q R) (if P R))))
   (rule (term (if P Q)) (rule (term P) (term Q)))
   (rule Q (Q))
   (rule P (P))
   (rule P (Q))
   (rule Q (R))
   (rule R (R))
   (rule P (if (P) (Q)))
   (rule Q (if (if (Q) (R)) (if (P) (R))))
   (rule P (if (Q) (R)))
   (rule Q (if (P) (R)))))


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

 '((term (triple (x) (y) (z)))
   (rule (term P) (map (rule (x) (y)) (term P)))
   (rule P (triple (x) (y) (z)))))


(test-case

 '(eval (map (map (rule P (triple (x) (y) (z)))
                  (rule (term P) (map (rule (x) (y)) (term P))))
             (term (triple (x) (y) (z)))))

 '((rule P (triple (x) (y) (z)))
   (rule (term P) (map (rule (x) (y)) (term P)))
   (term (triple (x) (y) (z)))))


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

    rule-x)

 '((term (if (P) (Q)))
   (rule (term (if P Q)) (rule (term P) (term Q)))
   (rule Q (Q))
   (rule P (P))))


(test-case
 ;;
 ;; Some proof with an assumption.
 ;;

 '(begin
    (define ax1
      (rule (term (R)) (term (W))))

    (define thm
      (let ((x (term (R))))
        (map ax1 x)))

    thm

    )

 '((rule (term (R)) (term (W)))))


(test-case
 ;;
 ;; Some proof with an abstract assumption.
 ;;

 '(begin
    (define ax1
      (rule (term R) (term (W))))

    (define thm
      (let ((x (term R)))
        (map ax1 x)))

    thm

    )

 '((rule (term R) (term (W)))))


(test-case
 ;;
 ;; Some proof with multiple assumptions.
 ;;

 '(begin
    (define ax1
      (rule (term (R)) (term (W))))

    (define thm
      (let ((x (term (P))))
        (let ((y (term (Q))))
          (let ((z (term (R))))
            (map ax1 z)))))

    thm

    )

 '((rule (term (R)) (term (W)))))
