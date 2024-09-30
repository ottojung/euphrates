

(define (test-case program expected-mapping)
  (define result/wrapped
    (lesya:interpret program))

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
 ;; Basic proof with disjunction 2.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
 ;;

 '(begin
    (define and-elim
      (lift
       (axiom (if (and X Y) X))))
    (define and-symmetric
      (lift
       (axiom (if (and X Y) (and Y X)))))

    (= and-elim
       (rule (term (and X Y))
             (term X)))

    (define spec1 (specify X (P)))
    (= spec1 (rule X (P)))
    (define spec2 (specify Y (Q)))
    (= spec2 (rule Y (Q)))

    (define s1 (map spec1 and-symmetric))
    (define s2 (map spec2 s1))
    (define r1 (map spec1 and-elim))
    (define r2 (map spec2 r1))

    (= s2
       (rule (term (and (P) (Q)))
             (term (and (Q) (P)))))

    (= r2
       (rule (term (and (P) (Q)))
             (term (P))))

    (define theorem
      (let ((m (and (P) (Q))))

        (= m (term (and (P) (Q))))

        (define swapped (map s2 m))

        (= swapped (term (and (Q) (P))))

        (map r2 swapped)))

    (= theorem
       (term (if (and (P) (Q))
                 (and (Q) (P)))))

    )

 `ignore-ok)



(test-case
 ;;
 ;;  Proof of negation rule for existential quantifier.
 ;;

 '(begin

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Propositional axioms:
    ;;

    (define MP ;; The "modus ponens" law.
      (lift (axiom (if P (if (if P Q) Q)))))
    (define DN ;; The "double negation" law.
      (lift (axiom (if (not (not P)) P))))
    (define EFQ ;; The "ex-falso-quodlibet" law.
      (lift (axiom (if (false) P))))
    (define Abs ;; The "absurdity rule" law.
      (lift (axiom (if (and P (not P)) (false)))))
    (define RAA ;; The "reductio ad absurdum" law.
      (lift (axiom (if (if P (false)) (not P)))))
    (define CP ;; The "contraposition" law.
      (lift (axiom (if (if P Q) (if (not P) (not Q))))))
    (define LEM ;; The "law of excluded middle".
      (axiom (or P (not P))))

    (define and-intro
      (lift (axiom (if P (if Q (and P Q))))))
    (define and-elim-left
      (lift (axiom (if (and P Q) P))))
    (define and-elim-right
      (lift (axiom (if (and P Q) Q))))

    (define or-intro-left
      (lift (axiom (if P (or P Q)))))
    (define or-intro-right
      (lift (axiom (if Q (or P Q)))))
    (define or-elim
      (lift (axiom (if (or P Q) (if (if P R) (if (if Q R) R))))))

    (define implication-intro
      (lift (axiom (if (or (not P) Q) (if P Q)))))
    (define implication-elim
      (lift (axiom (if (if P Q) (or (not P) Q)))))

    (define not-intro
      RAA)
    (define not-elim
      DN)

    (define true-intro
      (lift (axiom (if P (true)))))
    (define true-elim
      (lift (axiom (if (not (true)) (false)))))
    (define false-intro
      Abs)
    (define false-elim
      EFQ)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Quantifier rules:
    ;;

    (define universal-instantiation
      (lift (axiom (if t (if (forall x B) (map (rule x t) B))))))

    (define universal-generalization
      (lift (axiom (if c (if (if x Q) (if (if x c) (map (rule x c) (forall c Q))))))))

    (define existential-generalization
      (lift (axiom (if c (if B (map (rule t c) (exists c B)))))))

    (define existential-instantiation
      (lift (axiom (if (exists x B) (map (rule x (exists x B)) B)))))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Useful theorems:
    ;;

    (define de-morgan-/
      (lift (axiom (if (not (or P Q)) (and (not P) (not Q))))))

    (define if-negation
      (lift (axiom (if (not (if P Q)) (and P (not Q))))))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Theorem:
    ;;

    (define theorem
      (let ()

        (define spec1 (specify t P))
        (define spec2 (specify x (x)))
        (define spec3 (specify B (not P)))
        (define spec4 (specify B P))

        (define universal-instantiation-1
          (= (map spec1
                  (map spec2
                       (map spec3
                            universal-instantiation)))
             (rule (term P)
                   (term (if (forall (x) (not P))
                             (map (rule (x) P) (not P)))))))

        (define existential-instantiation-1
          (= (map spec2 (map spec4 existential-instantiation))
             (rule (term (exists (x) P))
                   (term (map (rule (x) (exists (x) P)) P)))))

        (define and-intro-1
          (= (map (specify Q (not P))
                  (map (specify P P)
                       and-intro))

             (rule (term P)
                   (term (if (not P)
                             (and P (not P)))))))

        (define abs-1
          (= (map (specify P P) Abs)
             (rule (term (and P (not P)))
                   (term (false)))))

        (define raa-1
          (= (map (specify P (forall (x) (not P))) RAA)
             (rule (term (if (forall (x) (not P)) (false)))
                   (term (not (forall (x) (not P)))))))

        (let ((premise (exists (x) P)))

          (define conclusion->false
            (let ((not-conclusion (forall (x) (not P))))

              (define instance-2/text
                (= (map existential-instantiation-1 premise)
                   (term (map (rule (x) (exists (x) P)) P))))

              (define instance-2
                (= (eval instance-2/text)
                   P))

        ;;       (define instance/text
        ;;         (= (eval (list universal-instantiation-1 instance-2 not-conclusion))
        ;;            (map (if (x) P) (not P))))

              (define instance/text/1
                (= (map universal-instantiation-1 instance-2)
                   P))

        ;;       (define instance
        ;;         (= (eval instance/text)
        ;;            (not P)))

        ;;       (define both-instances
        ;;         (eval (list and-intro-1 instance-2 instance)))

        ;;       (define false
        ;;         (= (eval (list abs-1 both-instances))
        ;;            (false)))

        ;;       false))

        ;;   (eval (list raa-1 conclusion->false))

              not-conclusion))

          premise)

        0

          ))

    ;; (= theorem
    ;;    (if (exists (x) P)
    ;;        (not (forall (x) (not P)))))

    )

 'ignore-ok)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Old inner model:
;;



;; (test-case
;;  ;;
;;  ;; Basic proof.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 6.
;;  ;;

;;  '(begin

;;     (define x
;;       (axiom (if (P) (Q))))
;;     (define y
;;       (axiom (if (Q) (R))))

;;     (define z
;;       (let ((p (P)))
;;         (define v1 (apply x p))
;;         (define v2 (apply y v1))
;;         v2)))

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 6.
;;  ;;

;;  '(begin

;;     (define y
;;       (axiom (if (P) (if (Q) (R)))))

;;     (define z
;;       (let ((q (Q)))
;;         (let ((p (P)))
;;           (define v1 (apply y p))
;;           (apply v1 q)))))

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))
;;     (define and-intro
;;       (axiom (if X (if Y (and X Y)))))

;;     (define x
;;       (let ()
;;         (define and-intro-p-q
;;           (map (if Y (Q)) (map (if X (P)) and-intro)))

;;         (let ((y (P))
;;               (w (Q)))
;;           (apply (apply and-intro-p-q y) w))))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (if X (P)) and-elim))
;;     (define r2 (map (if Y (Q)) r1))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (apply r2 m)))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction 2.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define s1 (map (if X (P)) and-symmetric))
;;     (define s2 (map (if Y (Q)) s1))
;;     (define r1 (map (if X (Q)) and-elim))
;;     (define r2 (map (if Y (P)) r1))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (define swapped (apply s2 m))
;;         (apply r2 swapped)))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof trivial.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(define x (let ((p (P))) p))

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof via reductio ad absurdum.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 8.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))
;;     (define and-intro
;;       (axiom (if X (if Y (and X Y)))))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and X (not X)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if X (false)) (not X))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not X)) X)))

;;     (define premise-1
;;       (axiom (if (P) (Q))))

;;     (define x
;;       (let ()
;;         (define r1 (map (if X (P)) and-elim))
;;         (define r2 (map (if Y (not (Q))) r1))
;;         (define s1 (map (if X (P)) and-symmetric))
;;         (define s2 (map (if Y (not (Q))) s1))
;;         (define sr1 (map (if X (not (Q))) and-elim))
;;         (define sr2 (map (if Y (P)) sr1))
;;         (define Abs-q (map (if X (Q)) Abs))
;;         (define RAA-target (map (if X (and (P) (not (Q)))) RAA))
;;         (define and-intro-q-notq (map (if Y (not (Q))) (map (if X (Q)) and-intro)))

;;         (define tofalse
;;           (let ((m (and (P) (not (Q)))))
;;             (define p (apply r2 m))
;;             (define swapped (apply s2 m))
;;             (define notq (apply sr2 swapped))
;;             (define q (apply premise-1 p))
;;             (define q-and-notq (apply (apply and-intro-q-notq q) notq))
;;             (define bot (apply Abs-q q-and-notq))
;;             bot))

;;         (apply RAA-target tofalse)))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof via reductio ad absurdum. Reduce export by using `let`.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 8.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))
;;     (define and-intro
;;       (axiom (if X (if Y (and X Y)))))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and X (not X)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if X (false)) (not X))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not X)) X)))

;;     (define premise-1
;;       (axiom (if (P) (Q))))

;;     (define x
;;       (let ()
;;         (define r1 (map (if X (P)) and-elim))
;;         (define r2 (map (if Y (not (Q))) r1))
;;         (define s1 (map (if X (P)) and-symmetric))
;;         (define s2 (map (if Y (not (Q))) s1))
;;         (define sr1 (map (if X (not (Q))) and-elim))
;;         (define sr2 (map (if Y (P)) sr1))
;;         (define Abs-q (map (if X (Q)) Abs))
;;         (define RAA-target (map (if X (and (P) (not (Q)))) RAA))
;;         (define and-intro-q-notq (map (if Y (not (Q))) (map (if X (Q)) and-intro)))

;;         (define tofalse
;;           (let ((m (and (P) (not (Q)))))
;;             (define p (apply r2 m))
;;             (define swapped (apply s2 m))
;;             (define notq (apply sr2 swapped))
;;             (define q (apply premise-1 p))
;;             (define q-and-notq (apply (apply and-intro-q-notq q) notq))
;;             (define bot (apply Abs-q q-and-notq))
;;             bot))

;;         (apply RAA-target tofalse)))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof via reductio ad absurdum [2].
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 8.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))
;;     (define and-intro
;;       (axiom (if X (if Y (and X Y)))))
;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;;       (axiom (if (false) X)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and X (not X)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if X (false)) (not X))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not X)) X)))

;;     (define premise-1
;;       (axiom (not (and (P) (not (Q))))))

;;     (define x
;;       (let ()
;;         (define r1 (map (if X (P)) and-elim))
;;         (define r2 (map (if Y (not (Q))) r1))
;;         (define s1 (map (if X (P)) and-symmetric))
;;         (define s2 (map (if Y (not (Q))) s1))
;;         (define sr1 (map (if X (not (Q))) and-elim))
;;         (define sr2 (map (if Y (P)) sr1))
;;         (define Abs-1 (map (if X (and (P) (not (Q)))) Abs))
;;         (define RAA-target (map (if X (not (Q))) RAA))
;;         (define DN-target (map (if X (Q)) DN))
;;         (define and-intro-p-notq (map (if Y (not (Q))) (map (if X (P)) and-intro)))
;;         (define and-intro-p-notq-premise-1
;;           (map (if Y (not (and (P) (not (Q)))))
;;                (map (if X (and (P) (not (Q)))) and-intro)))

;;         (let ((p (P)))
;;           (define contr1
;;             (let ((notq (not (Q))))
;;               (define and-p-notq (apply (apply and-intro-p-notq p) notq))
;;               ;; (define contr1 (and and-p-notq premise-1))
;;               (define contr1 (apply (apply and-intro-p-notq-premise-1 and-p-notq) premise-1))
;;               (define abs1 (apply Abs-1 contr1))
;;               abs1))

;;           (define nnq (apply RAA-target contr1))
;;           (apply DN-target nnq))))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic case-proof. (Proving distributivity of conjunction over disjunction).
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 9.
;;  ;; Note: the proof there seems to be wrong, actually.
;;  ;;

;;  '(begin
;;     (define or-intro-left
;;       (axiom (if X (or X Y))))
;;     (define or-intro-right
;;       (axiom (if Y (or X Y))))
;;     (define or-symmetric
;;       (axiom (if (or X Y) (or Y X))))
;;     (define or-elim
;;       (axiom (if (or X Y) (if (if X Z) (if (if Y Z) Z)))))
;;     (define and-intro
;;       (axiom (if X (if Y (and X Y)))))
;;     (define and-elim-left
;;       (axiom (if (and X Y) X)))
;;     (define and-elim-right
;;       (axiom (if (and X Y) Y)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))
;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;;       (axiom (if (false) X)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and X (not X)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if X (false)) (not X))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not X)) X)))

;;     (define premise-1
;;       (axiom (and (P) (or (Q) (R)))))

;;     (define x
;;       (let ()
;;         (define and-intro-p-q (map (if Y (Q)) (map (if X (P)) and-intro)))
;;         (define and-intro-p-r (map (if Y (R)) (map (if X (P)) and-intro)))
;;         (define or-intro-p-q-p-r-1 (map (if Y (and (P) (R))) (map (if X (and (P) (Q))) or-intro-left)))
;;         (define or-intro-p-q-p-r-2 (map (if Y (and (P) (R))) (map (if X (and (P) (Q))) or-intro-right)))
;;         (define p (apply (map (if Y (or (Q) (R))) (map (if X (P)) and-elim-left))
;;                          premise-1))
;;         (define reversed (apply (map (if Y (or (Q) (R))) (map (if X (P)) and-symmetric))
;;                                 premise-1))

;;         (define or-elim-target
;;           (let ()
;;             (define a (map (if X (Q)) or-elim))
;;             (define b (map (if Y (R)) a))
;;             (define c (map (if Z (or (and (P) (Q)) (and (P) (R)))) b))
;;             c))

;;         (define or-q-r (apply (map (if X (or (Q) (R))) (map (if Y (P)) and-elim-left)) reversed))

;;         (define q-><p-&-q/p-&-r>
;;           (let ((q (Q)))
;;             (define p-and-q
;;               (apply and-intro-p-q p q))

;;             (apply or-intro-p-q-p-r-1 p-and-q)))

;;         (define r-><p-&-q/p-&-r>
;;           (let ((r (R)))
;;             (define p-and-r
;;               (apply (apply and-intro-p-r p) r))

;;             (apply or-intro-p-q-p-r-2 p-and-r)))

;;         (define or-elim-target-1
;;           (apply or-elim-target or-q-r))

;;         (define or-elim-target-2
;;           (apply or-elim-target-1 q-><p-&-q/p-&-r>))

;;         (define or-elim-target-3
;;           (apply or-elim-target-2 r-><p-&-q/p-&-r>))

;;         or-elim-target-3))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Derivation of ((P /\ ~P) -> Q) without EFQ law.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 11.
;;  ;;

;;  '(begin
;;     (define or-intro-left
;;       (axiom (if X (or X Y))))
;;     (define or-intro-right
;;       (axiom (if Y (or X Y))))
;;     (define or-symmetric
;;       (axiom (if (or X Y) (or Y X))))
;;     (define or-elim
;;       (axiom (if (or X Y) (if (if X Z) (if (if Y Z) Z)))))
;;     (define and-intro
;;       (axiom (if X (if Y (and X Y)))))
;;     (define and-elim-left
;;       (axiom (if (and X Y) X)))
;;     (define and-elim-right
;;       (axiom (if (and X Y) Y)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))
;;     ;; (define EFQ ;; The "ex-falso-quodlibet" law.
;;     ;;   (axiom (if (false) X)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and X (not X)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if X (false)) (not X))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not X)) X)))

;;     (define x
;;       (let ()

;;         (define and-elim-left-notp-notq
;;           (map (if Y (not Q)) (map (if X (not P)) and-elim-left)))

;;         (define and-elim-left-p-notp
;;           (map (if Y (not P)) (map (if X P) and-elim-left)))

;;         (define and-elim-right-p-notp
;;           (map (if Y (not P)) (map (if X P) and-elim-right)))

;;         (define and-intro-p-notp
;;           (map (if Y (not P)) (map (if X P) and-intro)))

;;         (define abs-p
;;           (map (if X P) Abs))

;;         (define raa1-rule (map (if X (and (not P) (not Q))) RAA))

;;         (define and-intro-notp-notq
;;           (= (map (if Y (not Q)) (map (if X (not P)) and-intro))
;;              (if (not P) (if (not Q) (and (not P) (not Q))))))

;;         (define and-intro-1
;;           (= (map (if Y (not (and (not P) (not Q)))) (map (if X (and (not P) (not Q))) and-intro))
;;              (if (and (not P) (not Q))
;;                  (if (not (and (not P) (not Q)))
;;                      (and (and (not P) (not Q)) (not (and (not P) (not Q))))))))

;;         (define abs-1
;;           (= (map (if X (and (not P) (not Q))) Abs)
;;              (if (and (and (not P) (not Q)) (not (and (not P) (not Q)))) (false))))

;;         (define notq-raa
;;           (= (map (if X (not Q)) RAA)
;;              (if (if (not Q) (false)) (not (not Q)))))

;;         (define DN-q
;;           (map (if X Q) DN))

;;         (let ((p-and-notp (and P (not P))))

;;           (define p (apply and-elim-left-p-notp p-and-notp))
;;           (define notp (apply and-elim-right-p-notp p-and-notp))

;;           (define false1
;;             (let ((not-p-and-not-q (and (not P) (not Q))))
;;               (define and-p-notp (apply (apply and-intro-p-notp p) notp))
;;               (apply abs-p and-p-notp)))

;;           (define raa1
;;             (= (apply raa1-rule false1)
;;                (not (and (not P) (not Q)))))

;;           (define not<q>->false
;;             (let ((notq (not Q)))
;;               (define and-p-notp
;;                 (= (apply (apply and-intro-notp-notq notp) notq)
;;                    (and (not P) (not Q))))

;;               (define y
;;                 (= (apply (apply and-intro-1 and-p-notp) raa1)
;;                    (and (and (not P) (not Q)) (not (and (not P) (not Q))))))

;;               (define yabs
;;                 (= (apply abs-1 y)
;;                    (false)))

;;               yabs))

;;           (= not<q>->false
;;              (if (not Q) (false)))

;;           (define not<not<q>>
;;             (= (apply notq-raa not<q>->false)
;;                (not (not Q))))

;;           (apply DN-q not<not<q>>))))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Test for unquote.
;;  ;;

;;  '(begin
;;     (define x
;;       (axiom (P)))

;;     (define y
;;       (axiom (and x ,x)))

;;     (define z
;;       (axiom (and x (unquote x))))

;;     )


;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction. With `eval` style.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (if X (P)) and-elim))
;;     ;; (define r2 (map (if Y (Q)) r1)) ;; equivalent to one below:
;;     (define r2 (eval (axiom (map (if Y (Q)) ,r1))))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (eval (list r2 m))))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Check error with `map` not on toplevel.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (if X (P)) and-elim))
;;     ;; (define r2 (map (if Y (Q)) r1)) ;; equivalent to one below:
;;     (define r2 (eval (axiom (map (if Y (Q)) ,r1))))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (define r1-internal (map (if X (P)) and-elim))
;;         (eval (list r2 m))))

;;     )

;;  `(error only-allowed-on-top-level
;;          ("This operation is only allowed on toplevel: (let () (define-values (premise conclusion) (lesya:implication:destruct (quasiquote (if X (P))))) (unless (symbol? premise) (lesya:error (quote non-symbol-1-in-map) premise conclusion and-elim)) (lesya:language:beta-reduce and-elim premise conclusion)).")
;;          (r1-internal x)))


;; (test-case
;;  ;;
;;  ;; Check bad modus ponens.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define thm
;;       (let ()
;;         (define thm2
;;           (let ()
;;             (define thm3
;;               (let ((t (and X Y Z)))
;;                 (eval (list and-elim t))))
;;             thm3))
;;         thm2))

;;     )

;;  `(error non-matching-modus-ponens
;;          ((context:
;;            argument:
;;            (and X Y Z)
;;            implication:
;;            (if (and X Y) X)
;;            endcontext:))
;;          (thm3 thm2 thm)))


;; (test-case
;;  ;;
;;  ;; Derivation of ~(P /\ Q) -> ~P \/ ~Q (De-Morgan's law 1)
;;  ;;

;;  '(begin

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Propositional axioms:
;;     ;;

;;     (define MP ;; The "modus ponens" law.
;;       (axiom (if P (if (if P Q) Q))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not P)) P)))
;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;;       (axiom (if (false) P)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and P (not P)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if P (false)) (not P))))
;;     (define CP ;; The "contraposition" law.
;;       (axiom (if (if P Q) (if (not P) (not Q)))))
;;     (define LEM ;; The "law of excluded middle".
;;       (axiom (or P (not P))))

;;     (define and-intro
;;       (axiom (if P (if Q (and P Q)))))
;;     (define and-elim-left
;;       (axiom (if (and P Q) P)))
;;     (define and-elim-right
;;       (axiom (if (and P Q) Q)))

;;     (define or-intro-left
;;       (axiom (if P (or P Q))))
;;     (define or-intro-right
;;       (axiom (if Q (or P Q))))
;;     (define or-elim
;;       (axiom (if (or P Q) (if (if P R) (if (if Q R) R)))))

;;     (define implication-intro
;;       (axiom (if (or (not P) Q) (if P Q))))
;;     (define implication-elim
;;       (axiom (if (if P Q) (or (not P) Q))))

;;     (define not-intro
;;       RAA)
;;     (define not-elim
;;       DN)

;;     (define true-intro
;;       (axiom (if P (true))))
;;     (define true-elim
;;       (axiom (if (not (true)) (false))))
;;     (define false-intro
;;       Abs)
;;     (define false-elim
;;       EFQ)

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Quantifier rules:
;;     ;;

;;     (define universal-instantiation
;;       (axiom (if t (if (forall x B) (map (if x t) B)))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (if x c) (forall c Q)))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (if t c) (exists c B))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (if x (exists x B)) B))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Theorem:
;;     ;;

;;     (define de-morgan-&
;;       (let ()
;;         (define contr-1a (map (if P (and P Q)) Abs))
;;         (define abs-1a (map (if P Q) Abs))
;;         (define and-intro-xy (map (if Q Y) (map (if P X) and-intro)))
;;         (define and-intro-andpq (map (if Y (not (and P Q)))
;;                                      (map (if X (and P Q)) and-intro-xy)))
;;         (define or-intro-right-xy (map (if Q Y) (map (if P X) or-intro-right)))
;;         (define or-intro-right-notq (map (if Y (not Q)) (map (if X (not P)) or-intro-right-xy)))
;;         (define or-intro-left-xy (map (if Q Y) (map (if P X) or-intro-left)))
;;         (define or-intro-left-notq (map (if Y (not Q)) (map (if X (not P)) or-intro-left-xy)))
;;         (define raa-notq (map (if P Q) RAA))
;;         (define ret (map (if R (or (not P) (not Q))) (map (if Q (not P)) or-elim)))

;;         (let ((premise (not (and P Q))))

;;           (define x
;;             (let ((p P))

;;               (define q->false
;;                 (let ((q Q))
;;                   (define andpq
;;                     (eval (list and-intro p q)))

;;                   (define contr-1a-input
;;                     (eval (list and-intro-andpq andpq premise)))

;;                   (eval (list contr-1a contr-1a-input))))

;;               (define notq->ret
;;                 (let ((notq (not Q)))
;;                   (eval (list or-intro-right-notq notq))))

;;               (define notq
;;                 (eval (list raa-notq q->false)))

;;               (eval (list notq->ret notq))))

;;           (define y
;;             (let ((notp (not P)))
;;               (eval (list or-intro-left-notq notp))))

;;           (define z
;;             (eval (list ret LEM x y)))

;;           z)))

;;     (= de-morgan-&
;;        (if (not (and P Q)) (or (not P) (not Q))))

;;     )

;;  'ignore-ok)


;; (test-case
;;  ;;
;;  ;;  Proof of negation rule for universal quantifier.
;;  ;;

;;  '(begin

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Propositional axioms:
;;     ;;

;;     (define MP ;; The "modus ponens" law.
;;       (axiom (if P (if (if P Q) Q))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not P)) P)))
;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;;       (axiom (if (false) P)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and P (not P)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if P (false)) (not P))))
;;     (define CP ;; The "contraposition" law.
;;       (axiom (if (if P Q) (if (not P) (not Q)))))
;;     (define LEM ;; The "law of excluded middle".
;;       (axiom (or P (not P))))

;;     (define and-intro
;;       (axiom (if P (if Q (and P Q)))))
;;     (define and-elim-left
;;       (axiom (if (and P Q) P)))
;;     (define and-elim-right
;;       (axiom (if (and P Q) Q)))

;;     (define or-intro-left
;;       (axiom (if P (or P Q))))
;;     (define or-intro-right
;;       (axiom (if Q (or P Q))))
;;     (define or-elim
;;       (axiom (if (or P Q) (if (if P R) (if (if Q R) R)))))

;;     (define implication-intro
;;       (axiom (if (or (not P) Q) (if P Q))))
;;     (define implication-elim
;;       (axiom (if (if P Q) (or (not P) Q))))

;;     (define not-intro
;;       RAA)
;;     (define not-elim
;;       DN)

;;     (define true-intro
;;       (axiom (if P (true))))
;;     (define true-elim
;;       (axiom (if (not (true)) (false))))
;;     (define false-intro
;;       Abs)
;;     (define false-elim
;;       EFQ)

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Quantifier rules:
;;     ;;

;;     (define universal-instantiation
;;       (axiom (if t (if (forall x B) (map (if x t) B)))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (if x c) (forall c Q)))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (if t c) (exists c B))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (if x (exists x B)) B))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Useful theorems:
;;     ;;

;;     (define de-morgan-/
;;       (axiom (if (not (or P Q)) (and (not P) (not Q)))))

;;     (define if-negation
;;       (axiom (if (not (if P Q)) (and P (not Q)))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Theorem:
;;     ;;

;;     (define theorem
;;       (let ()

;;         (define universal-instantiation-1
;;           (= (map (if t (exists (x) (not P)))
;;                   (map (if x (x))
;;                        (map (if B P)
;;                             universal-instantiation)))
;;              (if (exists (x) (not P))
;;                  (if (forall (x) P)
;;                      (map (if (x) (exists (x) (not P))) P)))))

;;         (define existential-instantiation-1
;;           (= (map (if x (x)) (map (if B (not P)) existential-instantiation))
;;              (if (exists (x) (not P))
;;                  (map (if (x) (exists (x) (not P)))
;;                       (not P)))))

;;         (define and-intro-1
;;           (= (map (if Q (not P))
;;                   (map (if P P)
;;                        and-intro))
;;              (if P
;;                  (if (not P)
;;                      (and P
;;                           (not P))))))

;;         (define abs-1
;;           (= (map (if P P) Abs)
;;              (if (and P
;;                       (not P))
;;                  (false))))

;;         (define raa-1
;;           (= (map (if P (exists (x) (not P))) RAA)
;;              (if (if (exists (x) (not P)) (false))
;;                  (not (exists (x) (not P))))))

;;         (let ((premise (forall (x) P)))

;;           (define conclusion->false
;;             (let ((not-conclusion (exists (x) (not P))))

;;               (define c not-conclusion)

;;               (define instance/text
;;                 (= (eval (list existential-instantiation-1 not-conclusion))
;;                    (map (if (x) (exists (x) (not P)))
;;                         (not P))))

;;               (define instance
;;                 (= (eval instance/text)
;;                    (not P)))

;;               (define instance-2/text
;;                 (= (eval (list universal-instantiation-1 c premise))
;;                    (map (if (x) (exists (x) (not P))) P)))

;;               (define instance-2
;;                 (= (eval instance-2/text)
;;                    P))

;;               (define both-instances
;;                 (eval (list and-intro-1 instance-2 instance)))

;;               (define false
;;                 (= (eval (list abs-1 both-instances))
;;                    (false)))

;;               false))

;;           (eval (list raa-1 conclusion->false)))))

;;     (= theorem
;;        (if (forall (x) P)
;;            (not (exists (x) (not P)))))

;;     )

;;  'ignore-ok)


;; (test-case
;;  ;;
;;  ;;  Proof of negation rule for existential quantifier.
;;  ;;

;;  '(begin

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Propositional axioms:
;;     ;;

;;     (define MP ;; The "modus ponens" law.
;;       (axiom (if P (if (if P Q) Q))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not P)) P)))
;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;;       (axiom (if (false) P)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and P (not P)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if P (false)) (not P))))
;;     (define CP ;; The "contraposition" law.
;;       (axiom (if (if P Q) (if (not P) (not Q)))))
;;     (define LEM ;; The "law of excluded middle".
;;       (axiom (or P (not P))))

;;     (define and-intro
;;       (axiom (if P (if Q (and P Q)))))
;;     (define and-elim-left
;;       (axiom (if (and P Q) P)))
;;     (define and-elim-right
;;       (axiom (if (and P Q) Q)))

;;     (define or-intro-left
;;       (axiom (if P (or P Q))))
;;     (define or-intro-right
;;       (axiom (if Q (or P Q))))
;;     (define or-elim
;;       (axiom (if (or P Q) (if (if P R) (if (if Q R) R)))))

;;     (define implication-intro
;;       (axiom (if (or (not P) Q) (if P Q))))
;;     (define implication-elim
;;       (axiom (if (if P Q) (or (not P) Q))))

;;     (define not-intro
;;       RAA)
;;     (define not-elim
;;       DN)

;;     (define true-intro
;;       (axiom (if P (true))))
;;     (define true-elim
;;       (axiom (if (not (true)) (false))))
;;     (define false-intro
;;       Abs)
;;     (define false-elim
;;       EFQ)

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Quantifier rules:
;;     ;;

;;     (define universal-instantiation
;;       (axiom (if t (if (forall x B) (map (if x t) B)))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (if x c) (forall c Q)))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (if t c) (exists c B))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (if x (exists x B)) B))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Useful theorems:
;;     ;;

;;     (define de-morgan-/
;;       (axiom (if (not (or P Q)) (and (not P) (not Q)))))

;;     (define if-negation
;;       (axiom (if (not (if P Q)) (and P (not Q)))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Theorem:
;;     ;;

;;     (define theorem
;;       (let ()

;;         (define universal-instantiation-1
;;           (= (map (if t P)
;;                   (map (if x (x))
;;                        (map (if B (not P))
;;                             universal-instantiation)))
;;              (if P
;;                  (if (forall (x) (not P))
;;                      (map (if (x) P) (not P))))))

;;         (define existential-instantiation-1
;;           (= (map (if x (x)) (map (if B P) existential-instantiation))
;;              (if (exists (x) P)
;;                  (map (if (x) (exists (x) P)) P))))

;;         (define and-intro-1
;;           (= (map (if Q (not P))
;;                   (map (if P P)
;;                        and-intro))
;;              (if P
;;                  (if (not P)
;;                      (and P
;;                           (not P))))))

;;         (define abs-1
;;           (= (map (if P P) Abs)
;;              (if (and P
;;                       (not P))
;;                  (false))))

;;         (define raa-1
;;           (= (map (if P (forall (x) (not P))) RAA)
;;              (if (if (forall (x) (not P)) (false))
;;                  (not (forall (x) (not P))))))

;;         (let ((premise (exists (x) P)))

;;           (define conclusion->false
;;             (let ((not-conclusion (forall (x) (not P))))

;;               (define instance-2/text
;;                 (= (eval (list existential-instantiation-1 premise))
;;                    (map (if (x) (exists (x) P)) P)))

;;               (define instance-2
;;                 (= (eval instance-2/text)
;;                    P))

;;               (define instance/text
;;                 (= (eval (list universal-instantiation-1 instance-2 not-conclusion))
;;                    (map (if (x) P) (not P))))

;;               (define instance
;;                 (= (eval instance/text)
;;                    (not P)))

;;               (define both-instances
;;                 (eval (list and-intro-1 instance-2 instance)))

;;               (define false
;;                 (= (eval (list abs-1 both-instances))
;;                    (false)))

;;               false))

;;           (eval (list raa-1 conclusion->false)))))

;;     (= theorem
;;        (if (exists (x) P)
;;            (not (forall (x) (not P)))))

;;     )

;;  'ignore-ok)


;; (test-case
;;  ;;
;;  ;;  Basic proof with quantifiers.
;;  ;;  Taken from "First Order Logic and Automated Theorem Proving",
;;  ;;     second edition, by Melvin Fitting, page 154.
;;  ;;

;;  '(begin

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Propositional axioms:
;;     ;;

;;     (define MP ;; The "modus ponens" law.
;;       (axiom (if P (if (if P Q) Q))))
;;     (define DN ;; The "double negation" law.
;;       (axiom (if (not (not P)) P)))
;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;;       (axiom (if (false) P)))
;;     (define Abs ;; The "absurdity rule" law.
;;       (axiom (if (and P (not P)) (false))))
;;     (define RAA ;; The "reductio ad absurdum" law.
;;       (axiom (if (if P (false)) (not P))))
;;     (define CP ;; The "contraposition" law.
;;       (axiom (if (if P Q) (if (not P) (not Q)))))
;;     (define LEM ;; The "law of excluded middle".
;;       (axiom (or P (not P))))

;;     (define and-intro
;;       (axiom (if P (if Q (and P Q)))))
;;     (define and-elim-left
;;       (axiom (if (and P Q) P)))
;;     (define and-elim-right
;;       (axiom (if (and P Q) Q)))

;;     (define or-intro-left
;;       (axiom (if P (or P Q))))
;;     (define or-intro-right
;;       (axiom (if Q (or P Q))))
;;     (define or-elim
;;       (axiom (if (or P Q) (if (if P R) (if (if Q R) R)))))

;;     (define implication-intro
;;       (axiom (if (or (not P) Q) (if P Q))))
;;     (define implication-elim
;;       (axiom (if (if P Q) (or (not P) Q))))

;;     (define not-intro
;;       RAA)
;;     (define not-elim
;;       DN)

;;     (define true-intro
;;       (axiom (if P (true))))
;;     (define true-elim
;;       (axiom (if (not (true)) (false))))
;;     (define false-intro
;;       Abs)
;;     (define false-elim
;;       EFQ)

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Quantifier rules:
;;     ;;

;;     (define universal-instantiation
;;       (axiom (if t (if (forall x B) (map (if x t) B)))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (if x c) (forall c Q)))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (if t c) (exists c B))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (if x (exists x B)) B))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Useful theorems:
;;     ;;

;;     (define de-morgan-/
;;       (axiom (if (not (or P Q)) (and (not P) (not Q)))))

;;     (define if-negation
;;       (axiom (if (not (if P Q)) (and P (not Q)))))

;;     (define universal-negation
;;       (axiom (if (not (forall (x) P))
;;                  (exists (x) (not P)))))

;;     (define existential-negation
;;       (axiom (if (not (exists (x) P))
;;                  (forall (x) (not P)))))

;;     (define universal->existential
;;       (axiom (if (forall (x) P)
;;                  (not (exists (x) (not P))))))

;;     (define existential->universal
;;       (axiom (if (exists (x) P)
;;                  (not (forall (x) (not P))))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Theorem:
;;     ;;

;;     (define theorem
;;       (let ()

;;         (define if-negation-1
;;           (map (if Q (or (exists (x) (P (x))) (forall (x) (Q (x)))))
;;                (map (if P (forall (x) (or (P (x)) (Q (x))))) if-negation)))

;;         (define and-elim-left-1
;;           (map (if Q (not (or (exists (x) (P (x)))
;;                               (forall (x) (Q (x))))))
;;                (map (if P (forall (x) (or (P (x)) (Q (x))))) and-elim-left)))

;;         (define and-elim-right-1
;;           (map (if Q (not (or (exists (x) (P (x)))
;;                               (forall (x) (Q (x))))))
;;                (map (if P (forall (x) (or (P (x)) (Q (x))))) and-elim-right)))

;;         (define de-morgan-/-1
;;           (=

;;            (map (if Q (forall (x) (Q (x))))
;;                 (map (if P (exists (x) (P (x)))) de-morgan-/))

;;            (if (not (or (exists (x) (P (x)))
;;                         (forall (x) (Q (x)))))
;;                (and (not (exists (x) (P (x))))
;;                     (not (forall (x) (Q (x))))))))

;;         (define and-elim-left-2
;;           (map (if Q (not (forall (x) (Q (x)))))
;;                (map (if P (not (exists (x) (P (x))))) and-elim-left)))

;;         (define and-elim-right-2
;;           (map (if Q (not (forall (x) (Q (x)))))
;;                (map (if P (not (exists (x) (P (x))))) and-elim-right)))

;;         (define negate-forall-q
;;           (= (map (if P (Q (x))) universal-negation)
;;              (if (not (forall (x) (Q (x))))
;;                  (exists (x) (not (Q (x)))))))

;;         (define existential-instantiation-1
;;           (= (map (if x (x)) (map (if B (not (Q (x)))) existential-instantiation))
;;              (if (exists (x) (not (Q (x))))
;;                  (map (if (x) (exists (x) (not (Q (x)))))
;;                       (not (Q (x)))))))

;;         (define negate-exists-p
;;           (= (map (if P (P (x))) existential-negation)
;;              (if (not (exists (x) (P (x))))
;;                  (forall (x) (not (P (x)))))))

;;         (define universal-instantiation-1
;;           (= (map (if t (exists (x) (not (Q (x)))))
;;                   (map (if x (x))
;;                        (map (if B (not (P (x)))) universal-instantiation)))
;;              (if (exists (x) (not (Q (x))))
;;                  (if (forall (x) (not (P (x))))
;;                      (map (if (x) (exists (x) (not (Q (x)))))
;;                           (not (P (x))))))))

;;         (define universal-instantiation-2
;;           (= (map (if t (exists (x) (not (Q (x)))))
;;                   (map (if x (x))
;;                        (map (if B (or (P (x)) (Q (x))))
;;                             universal-instantiation)))
;;              (if (exists (x) (not (Q (x))))
;;                  (if (forall (x) (or (P (x)) (Q (x))))
;;                      (map (if (x) (exists (x) (not (Q (x)))))
;;                           (or (P (x)) (Q (x))))))))

;;         (define and-intro-1
;;           (map (if Q (not (P (exists (x) (not (Q (x)))))))
;;                (map (if P (P (exists (x) (not (Q (x)))))) and-intro)))

;;         (define abs-p<c>
;;           (map (if P (P (exists (x) (not (Q (x)))))) Abs))

;;         (define and-intro-2
;;           (map (if Q (not (Q (exists (x) (not (Q (x)))))))
;;                (map (if P (Q (exists (x) (not (Q (x)))))) and-intro)))

;;         (define abs-q<c>
;;           (map (if P (Q (exists (x) (not (Q (x)))))) Abs))

;;         (define or-elim-1
;;           (map (if R (false))
;;                (map (if Q (Q (exists (x) (not (Q (x))))))
;;                     (map (if P (P (exists (x) (not (Q (x))))))
;;                          or-elim))))

;;         (= or-elim-1
;;            (if (or (P (exists (x) (not (Q (x)))))
;;                    (Q (exists (x) (not (Q (x))))))
;;                (if (if (P (exists (x) (not (Q (x))))) (false))
;;                    (if (if (Q (exists (x) (not (Q (x))))) (false))
;;                        (false)))))

;;         (define raa-final
;;           (map (if P (not (if (forall (x) (or (P (x)) (Q (x))))
;;                               (or (exists (x) (P (x))) (forall (x) (Q (x)))))))
;;                RAA))

;;         (define dn-final
;;           (map (if P (if (forall (x) (or (P (x)) (Q (x)))) (or (exists (x) (P (x))) (forall (x) (Q (x))))))
;;                DN))

;;         (define refutation
;;           (let ((resolution-1
;;                  (not (if (forall (x) (or (P (x)) (Q (x))))
;;                           (or (exists (x) (P (x)))
;;                               (forall (x) (Q (x))))))))

;;             (define statement
;;               (eval (list if-negation-1 resolution-1)))

;;             (define resolution-2
;;               (eval (list and-elim-left-1 statement)))

;;             (= resolution-2
;;                (forall (x) (or (P (x)) (Q (x)))))

;;             (define resolution-3
;;               (eval (list and-elim-right-1 statement)))

;;             (= resolution-3
;;                (not (or (exists (x) (P (x))) (forall (x) (Q (x))))))

;;             (define de-morganed-1
;;               (eval (list de-morgan-/-1 resolution-3)))

;;             (= de-morganed-1
;;                (and (not (exists (x) (P (x)))) (not (forall (x) (Q (x))))))

;;             (define resolution-4
;;               (= (eval (list and-elim-left-2 de-morganed-1))
;;                  (not (exists (x) (P (x))))))

;;             (define resolution-5
;;               (= (eval (list and-elim-right-2 de-morganed-1))
;;                  (not (forall (x) (Q (x))))))

;;             (define exists-notq
;;               (= (eval (list negate-forall-q resolution-5))
;;                  (exists (x) (not (Q (x))))))

;;             (define c exists-notq)

;;             (define resolution-6/text
;;               (= (eval (list existential-instantiation-1 exists-notq))
;;                  (map (if (x) ,c)
;;                       (not (Q (x))))))

;;             (define resolution-6
;;               (= (eval resolution-6/text)
;;                  (not (Q ,c))))

;;             (define forall-notp
;;               (= (eval (list negate-exists-p resolution-4))
;;                  (forall (x) (not (P (x))))))

;;             (define resolution-7/text
;;               (= (eval (list universal-instantiation-1 c forall-notp))
;;                  (map (if (x) ,c) (not (P (x))))))

;;             (define resolution-7
;;               (= (eval resolution-7/text)
;;                  (not (P ,c))))

;;             (define resolution-8/text
;;               (= (eval (list universal-instantiation-2 c resolution-2))
;;                  (map (if (x) (exists (x) (not (Q (x)))))
;;                       (or (P (x)) (Q (x))))))

;;             (define resolution-8
;;               (= (eval resolution-8/text)
;;                  (or (P ,c) (Q ,c))))

;;             (define first-case
;;               (let ((p<c> (P ,c)))

;;                 (define tuple
;;                   (eval (list and-intro-1 p<c> resolution-7)))

;;                 (define false
;;                   (eval (list abs-p<c> tuple)))

;;                 false))

;;             (define second-case
;;               (let ((resolution-10 (Q ,c)))

;;                 (define tuple
;;                   (eval (list and-intro-2 resolution-10 resolution-6)))

;;                 (define false
;;                   (eval (list abs-q<c> tuple)))

;;                 false))

;;             (define resolution-11
;;               (eval (list or-elim-1 resolution-8 first-case second-case)))

;;             (= resolution-11 (false))

;;             resolution-11))

;;         (define negated
;;           (eval (list raa-final refutation)))

;;         (define final
;;           (eval (list dn-final negated)))

;;         final))

;;     (= theorem
;;        (if (forall (x) (or (P (x)) (Q (x))))
;;            (or (exists (x) (P (x))) (forall (x) (Q (x))))))

;;     )

;;  'ignore-ok)
