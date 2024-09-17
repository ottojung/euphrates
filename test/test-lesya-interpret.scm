
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
              (euphrates:list-sort
               (hashmap->alist result)
               (lambda (a b)
                 (string<? (~s (car a)) (~s (car b)))))))

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
   (y (if (Q) (R)))
   (z (if (P) (R)))))


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
        (lambda (p (P))
          (define v1 (apply y p))
          (apply v1 q)))))

 `((y (if (P) (if (Q) (R))))
   (z (if (Q) (if (P) (R))))))


(test-case
 ;;
 ;; Basic proof with disjunction.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))

    (define x
      (lambda (y (P))
        (lambda (w (Q))
          (and y w))))

    )

 `((and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (x (if (P) (if (Q) (and (P) (Q)))))))


(test-case
 ;;
 ;; Basic proof with disjunction.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))

    (define r1 (beta (and-elim X) (P)))
    (define r2 (beta (r1 Y) (Q)))

    (define x
      (lambda (m (and (P) (Q)))
        (apply r2 m)))

    )

 `((and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (r1 (if (and (P) Y) (P)))
   (r2 (if (and (P) (Q)) (P)))
   (x (if (and (P) (Q)) (P)))))


(test-case
 ;;
 ;; Basic proof with disjunction 2.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))

    (define s1 (beta (and-symmetric X) (P)))
    (define s2 (beta (s1 Y) (Q)))
    (define r1 (beta (and-elim X) (Q)))
    (define r2 (beta (r1 Y) (P)))

    (define x
      (lambda (m (and (P) (Q)))
        (define swapped (apply s2 m))
        (apply r2 swapped)))

    )

 `((and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (r1 (if (and (Q) Y) (Q)))
   (r2 (if (and (Q) (P)) (Q)))
   (s1 (if (and (P) Y) (and Y (P))))
   (s2 (if (and (P) (Q)) (and (Q) (P))))
   (x (if (and (P) (Q)) (Q)))))


(test-case
 ;;
 ;; Basic proof trivial.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
 ;;

 '(define x (lambda (p (P)) p))

 `((x (if (P) (P)))))


(test-case
 ;;
 ;; Basic proof via reductio ad absurdum.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 8.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))
    (define RAA
      (axiom (if (false) X)))
    (define Abs
      (axiom (if (and X (not X)) (false))))
    (define premise-1
      (axiom (if (P) (Q))))

    (define r1 (beta (and-elim X) (P)))
    (define r2 (beta (r1 Y) (not (Q))))
    (define s1 (beta (and-symmetric X) (P)))
    (define s2 (beta (s1 Y) (not (Q))))
    (define sr1 (beta (and-elim X) (not (Q))))
    (define sr2 (beta (sr1 Y) (P)))
    (define Abs-q (beta (Abs X) (Q)))
    (define RAA-target (beta (RAA X) (not (and (P) (not (Q))))))

    (define x
      (lambda (m (and (P) (not (Q))))
        (define p (apply r2 m))
        (define swapped (apply s2 m))
        (define notq (apply sr2 swapped))
        (define q (apply premise-1 p))
        (define q-and-notq (and q notq))
        (define bot (apply Abs-q q-and-notq))
        (apply RAA-target bot)))

    )

 `((Abs (if (and X (not X)) (false)))
   (Abs-q (if (and (Q) (not (Q))) (false)))
   (RAA (if (false) X))
   (RAA-target
    (if (false) (not (and (P) (not (Q))))))
   (and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (premise-1 (if (P) (Q)))
   (r1 (if (and (P) Y) (P)))
   (r2 (if (and (P) (not (Q))) (P)))
   (s1 (if (and (P) Y) (and Y (P))))
   (s2 (if (and (P) (not (Q))) (and (not (Q)) (P))))
   (sr1 (if (and (not (Q)) Y) (not (Q))))
   (sr2 (if (and (not (Q)) (P)) (not (Q))))
   (x (if (and (P) (not (Q)))
          (not (and (P) (not (Q))))))))


(test-case
 ;;
 ;; Basic proof via reductio ad absurdum. Reduce export by using `let`.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 8.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))
    (define RAA
      (axiom (if (false) X)))
    (define Abs
      (axiom (if (and X (not X)) (false))))
    (define premise-1
      (axiom (if (P) (Q))))

    (define x
      (let ()
        (define r1 (beta (and-elim X) (P)))
        (define r2 (beta (r1 Y) (not (Q))))
        (define s1 (beta (and-symmetric X) (P)))
        (define s2 (beta (s1 Y) (not (Q))))
        (define sr1 (beta (and-elim X) (not (Q))))
        (define sr2 (beta (sr1 Y) (P)))
        (define Abs-q (beta (Abs X) (Q)))
        (define RAA-target (beta (RAA X) (not (and (P) (not (Q))))))

        (lambda (m (and (P) (not (Q))))
          (define p (apply r2 m))
          (define swapped (apply s2 m))
          (define notq (apply sr2 swapped))
          (define q (apply premise-1 p))
          (define q-and-notq (and q notq))
          (define bot (apply Abs-q q-and-notq))
          (apply RAA-target bot))))

    )

 `((Abs (if (and X (not X)) (false)))
   (RAA (if (false) X))
   (and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (premise-1 (if (P) (Q)))
   (x (if (and (P) (not (Q)))
          (not (and (P) (not (Q))))))))

(test-case
 ;;
 ;; Basic proof via reductio ad absurdum [2].
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 8.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))
    (define RAA
      (axiom (if (false) X)))
    (define Abs
      (axiom (if (and X (not X)) (false))))
    (define DN
      (axiom (if (not (not X)) X)))
    (define premise-1
      (axiom (not (and (P) (not (Q))))))

    (define x
      (let ()
        (define r1 (beta (and-elim X) (P)))
        (define r2 (beta (r1 Y) (not (Q))))
        (define s1 (beta (and-symmetric X) (P)))
        (define s2 (beta (s1 Y) (not (Q))))
        (define sr1 (beta (and-elim X) (not (Q))))
        (define sr2 (beta (sr1 Y) (P)))
        (define Abs-p-and-notq (beta (Abs X) (and (P) (not (Q)))))
        (define RAA-target (beta (RAA X) (not (not (Q)))))
        (define DN-q (beta (DN X) (Q)))

        (lambda (p (P))
          (define raa
            (lambda (notq (not (Q)))
              (define and-p-notq (and p notq))
              (define contr1 (and and-p-notq premise-1))
              (define abs1 (apply Abs-p-and-notq contr1))
              abs1))
          (define fin (apply DN-q raa))
          fin)))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (RAA (if (false) X))
   (and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (premise-1 (not (and (P) (not (Q)))))
   (x (if (P) (Q)))))
