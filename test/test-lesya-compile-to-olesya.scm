

(define (test-case program expected-code)
  (define lesya-interpretation
    (lesya:interpret program))

  (define expected-interpretation
    (lesya-object->olesya-object lesya-interpretation))

  (define actual
    (lesya:compile/->olesya program))

  (define (print-correct correct)
    (debugs correct)
    (exit 1))

  (unless (equal? actual expected-code)
    (print-correct actual))

  (assert= actual expected-code)

  (define interpretation
    (olesya:interpret actual))

  (unless (equal? interpretation expected-interpretation)
    (print-correct interpretation))

  (assert= interpretation expected-interpretation)

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
      (axiom (if (P) (Q))))
    (define y
      (axiom (if (Q) (R))))

    (define z
      (let ((p (P)))
        (define v1 (apply x p))
        (define v2 (apply y v1))
        v2))

    z)

 `(begin
    (define x (rule (term (P)) (term (Q))))
    (define y (rule (term (Q)) (term (R))))
    (define z
      (let ((p (term (P))))
        (define v1 (map x p))
        (define v2 (map y v1))
        v2))
    z)

 )



(test-case
 ;;
 ;; Basic with empty let.
 ;;

 '(begin

    (define x
      (axiom (if (P) (Q))))
    (define y
      (let ()
        (axiom (if (Q) (R)))))

    (define z
      (let ((p (P)))
        (define v1 (apply x p))
        (define v2 (apply y v1))
        v2))

    z)

 `(begin
    (define x (rule (term (P)) (term (Q))))
    (define y
      (let ()
        (rule (term (Q)) (term (R)))))
    (define z
      (let ((p (term (P))))
        (define v1 (map x p))
        (define v2 (map y v1))
        v2))
    z)

 )


(test-case
 ;;
 ;; Basic with empty let and multiple lets.
 ;;

 '(begin

    (define x
      (axiom (if (P) (Q))))
    (define y
      (let ()
        (axiom (if (Q) (R)))))

    (define z
      (let ((p (P))
            (k (K)))
        (define v1 (apply x p))
        (define v2 (apply y v1))
        v2))

    z)

 `(begin
    (define x (rule (term (P)) (term (Q))))
    (define y
      (let ()
        (rule (term (Q)) (term (R)))))
    (define z
      (let ((p (term (P)))
            (k (term (K))))
        (define v1 (map x p))
        (define v2 (map y v1))
        v2))
    z)

 )
