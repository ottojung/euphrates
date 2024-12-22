

(define (test-case program expected)
  (define actual
    (lesya:compile/->olesya program))

  (define (print-actual)
    (debugs actual)
    (exit 1))

  (unless (equal? actual expected)
    (print-actual))

  (assert= actual expected))




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
    (begin
      (define y (rule (term (Q)) (term (R))))
      (begin
        (define z
          (let ((p (term (P))))
            (let ()
              (begin
                (define v1 (map x p))
                (begin (define v2 (map y v1)) (map y v1))))))
        (let ((p (term (P))))
          (let ()
            (begin
              (define v1 (map x p))
              (begin (define v2 (map y v1)) (map y v1)))))))))
