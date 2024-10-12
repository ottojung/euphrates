
(define (test-case program expected)
  (define actual/stack
    (stack-make))

  (define value
    (olesya:trace:with-callback
     (lambda (op result)
       (stack-push! actual/stack (list op result))
       (assert= (olesya:language:eval op) result))

     (olesya:trace program)))

  (define actual
    (reverse
     (stack->list actual/stack)))

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

 '(((term (if (P) (Q))) (term (if (P) (Q))))
   ((term (if (Q) (R))) (term (if (Q) (R))))
   ((term (if P P)) (term (if P P)))
   ((term (if (if P Q) (if (if Q R) (if P R))))
    (term (if (if P Q) (if (if Q R) (if P R)))))
   ((rule (term (if P Q)) (rule (term P) (term Q)))
    (rule (term (if P Q)) (rule (term P) (term Q))))
   ((rule Q (Q)) (rule Q (Q)))
   ((rule P (P)) (rule P (P)))
   ((map (rule P (P))
         (rule (term (if P Q)) (rule (term P) (term Q))))
    (rule (term (if (P) Q))
          (rule (term (P)) (term Q))))
   ((map (rule Q (Q))
         (rule (term (if (P) Q))
               (rule (term (P)) (term Q))))
    (rule (term (if (P) (Q)))
          (rule (term (P)) (term (Q)))))
   ((map (rule (term (if (P) (Q)))
               (rule (term (P)) (term (Q))))
         (term (if (P) (Q))))
    (rule (term (P)) (term (Q))))
   ((rule P (Q)) (rule P (Q)))
   ((rule Q (R)) (rule Q (R)))
   ((map (rule Q (R))
         (rule (term (if P Q)) (rule (term P) (term Q))))
    (rule (term (if P (R)))
          (rule (term P) (term (R)))))
   ((map (rule P (Q))
         (rule (term (if P (R)))
               (rule (term P) (term (R)))))
    (rule (term (if (Q) (R)))
          (rule (term (Q)) (term (R)))))
   ((map (rule (term (if (Q) (R)))
               (rule (term (Q)) (term (R))))
         (term (if (Q) (R))))
    (rule (term (Q)) (term (R))))
   ((rule P (P)) (rule P (P)))
   ((map (rule P (P)) (term (if P P)))
    (term (if (P) (P))))
   ((rule P (P)) (rule P (P)))
   ((rule Q (Q)) (rule Q (Q)))
   ((rule R (R)) (rule R (R)))
   ((map (rule R (R))
         (term (if (if P Q) (if (if Q R) (if P R)))))
    (term (if (if P Q) (if (if Q (R)) (if P (R))))))
   ((map (rule Q (Q))
         (term (if (if P Q) (if (if Q (R)) (if P (R))))))
    (term (if (if P (Q)) (if (if (Q) (R)) (if P (R))))))
   ((map (rule P (P))
         (term (if (if P (Q)) (if (if (Q) (R)) (if P (R))))))
    (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R))))))
   ((rule P (if (P) (Q))) (rule P (if (P) (Q))))
   ((rule Q (if (if (Q) (R)) (if (P) (R))))
    (rule Q (if (if (Q) (R)) (if (P) (R)))))
   ((map (rule Q (if (if (Q) (R)) (if (P) (R))))
         (rule (term (if P Q)) (rule (term P) (term Q))))
    (rule (term (if P (if (if (Q) (R)) (if (P) (R)))))
          (rule (term P)
                (term (if (if (Q) (R)) (if (P) (R)))))))
   ((map (rule P (if (P) (Q)))
         (rule (term (if P (if (if (Q) (R)) (if (P) (R)))))
               (rule (term P)
                     (term (if (if (Q) (R)) (if (P) (R)))))))
    (rule (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R)))))
          (rule (term (if (P) (Q)))
                (term (if (if (Q) (R)) (if (P) (R)))))))
   ((map (rule (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R)))))
               (rule (term (if (P) (Q)))
                     (term (if (if (Q) (R)) (if (P) (R))))))
         (term (if (if (P) (Q)) (if (if (Q) (R)) (if (P) (R))))))
    (rule (term (if (P) (Q)))
          (term (if (if (Q) (R)) (if (P) (R))))))
   ((map (rule (term (if (P) (Q)))
               (term (if (if (Q) (R)) (if (P) (R)))))
         (term (if (P) (Q))))
    (term (if (if (Q) (R)) (if (P) (R)))))
   ((rule P (if (Q) (R))) (rule P (if (Q) (R))))
   ((rule Q (if (P) (R))) (rule Q (if (P) (R))))
   ((map (rule Q (if (P) (R)))
         (rule (term (if P Q)) (rule (term P) (term Q))))
    (rule (term (if P (if (P) (R))))
          (rule (term P) (term (if (P) (R))))))
   ((map (rule P (if (Q) (R)))
         (rule (term (if P (if (P) (R))))
               (rule (term P) (term (if (P) (R))))))
    (rule (term (if (if (Q) (R)) (if (P) (R))))
          (rule (term (if (Q) (R))) (term (if (P) (R))))))
   ((map (rule (term (if (if (Q) (R)) (if (P) (R))))
               (rule (term (if (Q) (R))) (term (if (P) (R)))))
         (term (if (if (Q) (R)) (if (P) (R)))))
    (rule (term (if (Q) (R))) (term (if (P) (R)))))
   ((map (rule (term (if (Q) (R))) (term (if (P) (R))))
         (term (if (Q) (R))))
    (term (if (P) (R))))))


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

 '(((term (triple (x) (y) (z)))
    (term (triple (x) (y) (z))))
   ((rule (term P) (map (rule (x) (y)) (term P)))
    (rule (term P) (map (rule (x) (y)) (term P))))
   ((rule P (triple (x) (y) (z)))
    (rule P (triple (x) (y) (z))))
   ((map (rule P (triple (x) (y) (z)))
         (rule (term P) (map (rule (x) (y)) (term P))))
    (rule (term (triple (x) (y) (z)))
          (map (rule (x) (y)) (term (triple (x) (y) (z))))))
   ((map (rule (term (triple (x) (y) (z)))
               (map (rule (x) (y)) (term (triple (x) (y) (z)))))
         (term (triple (x) (y) (z))))
    (map (rule (x) (y)) (term (triple (x) (y) (z)))))
   ((rule (x) (y)) (rule (x) (y)))
   ((term (triple (x) (y) (z)))
    (term (triple (x) (y) (z))))
   ((map (rule (x) (y)) (term (triple (x) (y) (z))))
    (term (triple (y) (y) (z))))
   ((eval (map (rule (x) (y)) (term (triple (x) (y) (z)))))
    (term (triple (y) (y) (z))))))


(test-case

 '(eval (map (map (rule P (triple (x) (y) (z)))
                  (rule (term P) (map (rule (x) (y)) (term P))))
             (term (triple (x) (y) (z)))))

 '(((rule P (triple (x) (y) (z)))
    (rule P (triple (x) (y) (z))))
   ((rule (term P) (map (rule (x) (y)) (term P)))
    (rule (term P) (map (rule (x) (y)) (term P))))
   ((map (rule P (triple (x) (y) (z)))
         (rule (term P) (map (rule (x) (y)) (term P))))
    (rule (term (triple (x) (y) (z)))
          (map (rule (x) (y)) (term (triple (x) (y) (z))))))
   ((term (triple (x) (y) (z)))
    (term (triple (x) (y) (z))))
   ((map (rule (term (triple (x) (y) (z)))
               (map (rule (x) (y)) (term (triple (x) (y) (z)))))
         (term (triple (x) (y) (z))))
    (map (rule (x) (y)) (term (triple (x) (y) (z)))))
   ((rule (x) (y)) (rule (x) (y)))
   ((term (triple (x) (y) (z)))
    (term (triple (x) (y) (z))))
   ((map (rule (x) (y)) (term (triple (x) (y) (z))))
    (term (triple (y) (y) (z))))
   ((eval (map (rule (x) (y)) (term (triple (x) (y) (z)))))
    (term (triple (y) (y) (z))))))


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

 '(((term (if (P) (Q))) (term (if (P) (Q))))
   ((rule (term (if P Q)) (rule (term P) (term Q)))
    (rule (term (if P Q)) (rule (term P) (term Q))))
   ((rule Q (Q)) (rule Q (Q)))
   ((rule P (P)) (rule P (P)))
   ((map (rule P (P))
         (rule (term (if P Q)) (rule (term P) (term Q))))
    (rule (term (if (P) Q))
          (rule (term (P)) (term Q))))
   ((map (rule Q (Q))
         (rule (term (if (P) Q))
               (rule (term (P)) (term Q))))
    (rule (term (if (P) (Q)))
          (rule (term (P)) (term (Q)))))
   ((map (rule (term (if (P) (Q)))
               (rule (term (P)) (term (Q))))
         (term (if (P) (Q))))
    (rule (term (P)) (term (Q))))))
