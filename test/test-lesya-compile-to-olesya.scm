

(define (test-case program expected-code)
  (define lesya-interpretation
    (lesya:interpret program))

  (define expected-interpretation
    (lesya-object->olesya-object 'not-possible-123798 lesya-interpretation))

  (define actual
    (lesya:compile/->olesya program))

  (define (print-correct correct)
    (debugs correct)
    (exit 1))

  (unless (equal? expected-code 'ignore-ok)
    (unless (equal? actual expected-code)
      (print-correct actual))

    (assert= actual expected-code))

  (define interpretation
    (olesya:interpret actual))

  (unless (olesya:return:fail? expected-interpretation)
    (unless (equal? interpretation expected-interpretation)
      (debug "----------------------------------")
      (debug "Bad interpretation:")
      (debugs interpretation)
      (debug "Expected:")
      (debugs expected-interpretation)
      (exit 1))

    (assert= interpretation expected-interpretation))

  )




;;;;;;;;;;;;;;;;;;;
;;
;;  Test cases:
;;


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction. With `eval`.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (specify X (P)) and-elim))
;;     (define r2 (eval (axiom (map (specify Y (Q)) (map (specify X (P)) (axiom (if (and X Y) X)))))))
;;     (= r2 (if (and (P) (Q)) (P)))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (apply r2 m)))

;;     x)

;;  `(begin
;;     (define and-elim (rule (and X Y) X))
;;     (define and-symmetric (rule (and X Y) (and Y X)))
;;     (define r1 (map (rule X (P)) and-elim))
;;     (define r2
;;       (eval (map (rule Y (Q))
;;                  (map (rule X (P)) (rule (and X Y) X)))))
;;     (rule (and (P) (Q)) (P))
;;     (define x
;;       (let ((m (term (and (P) (Q))))) (map r2 m)))
;;     x))


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction. With `eval` and `unquote`.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (specify X (P)) and-elim))
;;     (define r2 (eval (axiom (map (specify Y (Q)) (axiom ,r1)))))
;;     (= r2 (if (and (P) (Q)) (P)))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (apply r2 m)))

;;     )

;;  `ignore-ok)


;; (test-case
;;  ;;
;;  ;; Check fail with `map` not on toplevel.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (specify X (P)) and-elim))
;;     (define r2 (eval (axiom (map (specify Y (Q)) (axiom ,r1)))))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (define r1-internal (map (specify X (P)) and-elim))
;;         (apply r2 m)))

;;     )

;;  `(begin
;;     (define and-elim
;;       (rule (term (and X Y)) (term X)))
;;     (define and-symmetric
;;       (rule (term (and X Y)) (term (and Y X))))
;;     (define r1 (map (rule X (P)) and-elim))
;;     (define r2
;;       (eval (map (rule Y (Q))
;;                  (rule (term (and (P) Y)) (term (P))))))
;;     (define x
;;       (let ((m (term (and (P) (Q)))))
;;         (define r1-internal (map (rule X (P)) and-elim))
;;         (map r2 m)))))


;; (test-case
;;  ;;
;;  ;; Basic proof with disjunction. With `eval`.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(begin
;;     (define and-elim
;;       (axiom (if (and X Y) X)))
;;     (define and-symmetric
;;       (axiom (if (and X Y) (and Y X))))

;;     (define r1 (map (specify X (P)) and-elim))
;;     ;; (define r2 (eval (axiom (map (specify Y (Q)) (axiom ,r1)))))
;;     (define r2 (eval (axiom (map (specify Y (Q)) (map (specify X (P)) (axiom (if (and X Y) X)))))))
;;     (= r2 (if (and (P) (Q)) (P)))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (apply r2 m)))

;;     (= x (if (and (P) (Q)) (P)))

;;     )

;;  `ignore-ok)




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

    ;; (= z (if (P) (R)))

    z)

 `(begin
    (define x (term (if (P) (Q))))
    (define y (term (if (Q) (R))))
    (define z
      (let ()
        (define original-axiom
          (rule (rule (term P) (term Q)) (term (if P Q))))
        (define my-axiom
          (map (rule P (P))
               (map (rule Q (R)) original-axiom)))
        (map my-axiom
             (let ((p (term (P))))
               (define v1
                 (let ()
                   (define original-axiom
                     (rule (term (if P Q)) (rule (term P) (term Q))))
                   (define my-axiom
                     (map (rule P (P))
                          (map (rule Q (Q)) original-axiom)))
                   (define new-rule (map my-axiom x))
                   (map new-rule p)))
               (define v2
                 (let ()
                   (define original-axiom
                     (rule (term (if P Q)) (rule (term P) (term Q))))
                   (define my-axiom
                     (map (rule P (Q))
                          (map (rule Q (R)) original-axiom)))
                   (define new-rule (map my-axiom y))
                   (map new-rule v1)))
               v2))))
    z)

 )


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
;;         v2))

;;     z)

;;  `(begin
;;     (define x (rule (term (P)) (term (Q))))
;;     (define y (rule (term (Q)) (term (R))))
;;     (define z
;;       (let ((p (term (P))))
;;         (define v1 (map x p))
;;         (define v2 (map y v1))
;;         v2))
;;     z)

;;  )



;; (test-case
;;  ;;
;;  ;; Basic with empty let.
;;  ;;

;;  '(begin

;;     (define x
;;       (axiom (if (P) (Q))))
;;     (define y
;;       (let ()
;;         (axiom (if (Q) (R)))))

;;     (define z
;;       (let ((p (P)))
;;         (define v1 (apply x p))
;;         (define v2 (apply y v1))
;;         v2))

;;     z)

;;  `(begin
;;     (define x (rule (term (P)) (term (Q))))
;;     (define y
;;       (let ()
;;         (rule (term (Q)) (term (R)))))
;;     (define z
;;       (let ((p (term (P))))
;;         (define v1 (map x p))
;;         (define v2 (map y v1))
;;         v2))
;;     z)

;;  )


;; (test-case
;;  ;;
;;  ;; Basic with empty let and multiple lets.
;;  ;;

;;  '(begin

;;     (define x
;;       (axiom (if (P) (Q))))
;;     (define y
;;       (let ()
;;         (axiom (if (Q) (R)))))

;;     (define z
;;       (let ((p (P))
;;             (k (K)))
;;         (define v1 (apply x p))
;;         (define v2 (apply y v1))
;;         v2))

;;     z)

;;  `(begin
;;     (define x (rule (term (P)) (term (Q))))
;;     (define y
;;       (let ()
;;         (rule (term (Q)) (term (R)))))
;;     (define z
;;       (let ((p (term (P)))
;;             (k (term (K))))
;;         (define v1 (map x p))
;;         (define v2 (map y v1))
;;         v2))
;;     z)

;;  )


;; (test-case
;;  ;;
;;  ;; Basic with composite apply.
;;  ;;

;;  '(begin

;;     (define x
;;       (axiom (if (P) (Q))))
;;     (define y
;;       (axiom (if (Q) (R))))

;;     (define z
;;       (let ((p (P)))
;;         (define v1 (apply y (apply x p)))
;;         v1))

;;     z)

;;  `(begin
;;     (define x (rule (term (P)) (term (Q))))
;;     (define y (rule (term (Q)) (term (R))))
;;     (define z
;;       (let ((p (term (P))))
;;         (define v1 (map y (map x p)))
;;         v1))
;;     z)

;;  )


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
;;           (map (specify Y (Q))
;;                (map (specify X (P)) and-intro)))

;;         (let ((y (P))
;;               (w (Q)))
;;           (apply (apply and-intro-p-q y) w))))

;;     x)

;;  `(begin
;;     (define and-elim
;;       (rule (term (and X Y)) (term X)))
;;     (define and-symmetric
;;       (rule (term (and X Y)) (term (and Y X))))
;;     (define and-intro
;;       (rule (term X) (rule (term Y) (term (and X Y)))))
;;     (define x
;;       (let ()
;;         (define and-intro-p-q
;;           (map (rule Y (Q)) (map (rule X (P)) and-intro)))
;;         (let ((y (term (P))) (w (term (Q))))
;;           (map (map and-intro-p-q y) w))))

;;     x)

;;  )


;; (test-case
;;  ;;
;;  ;; Multi-argument apply.
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
;;           (map (specify Y (Q))
;;                (map (specify X (P)) and-intro)))

;;         (let ((y (P))
;;               (w (Q)))
;;           (apply and-intro-p-q y w))))

;;     x)

;;  `(begin
;;     (define and-elim
;;       (rule (term (and X Y)) (term X)))
;;     (define and-symmetric
;;       (rule (term (and X Y)) (term (and Y X))))
;;     (define and-intro
;;       (rule (term X) (rule (term Y) (term (and X Y)))))
;;     (define x
;;       (let ()
;;         (define and-intro-p-q
;;           (map (rule Y (Q)) (map (rule X (P)) and-intro)))
;;         (let ((y (term (P))) (w (term (Q))))
;;           (map (map and-intro-p-q y) w))))

;;     x)

;;  )





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

;;     (define r1 (map (specify X (P)) and-elim))
;;     (define r2 (map (specify Y (Q)) r1))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (apply r2 m)))

;;     x
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

;;     (define s1 (map (specify X (P)) and-symmetric))
;;     (define s2 (map (specify Y (Q)) s1))
;;     (define r1 (map (specify X (Q)) and-elim))
;;     (define r2 (map (specify Y (P)) r1))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (define swapped (apply s2 m))
;;         (apply r2 swapped)))

;;     x
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
;;         (define r1 (map (specify X (P)) and-elim))
;;         (define r2 (map (specify Y (not (Q))) r1))
;;         (define s1 (map (specify X (P)) and-symmetric))
;;         (define s2 (map (specify Y (not (Q))) s1))
;;         (define sr1 (map (specify X (not (Q))) and-elim))
;;         (define sr2 (map (specify Y (P)) sr1))
;;         (define Abs-q (map (specify X (Q)) Abs))
;;         (define RAA-target (map (specify X (and (P) (not (Q)))) RAA))
;;         (define and-intro-q-notq (map (specify Y (not (Q))) (map (specify X (Q)) and-intro)))

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
;;         (define r1 (map (specify X (P)) and-elim))
;;         (define r2 (map (specify Y (not (Q))) r1))
;;         (define s1 (map (specify X (P)) and-symmetric))
;;         (define s2 (map (specify Y (not (Q))) s1))
;;         (define sr1 (map (specify X (not (Q))) and-elim))
;;         (define sr2 (map (specify Y (P)) sr1))
;;         (define Abs-q (map (specify X (Q)) Abs))
;;         (define RAA-target (map (specify X (and (P) (not (Q)))) RAA))
;;         (define and-intro-q-notq (map (specify Y (not (Q))) (map (specify X (Q)) and-intro)))

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
;;         (define r1 (map (specify X (P)) and-elim))
;;         (define r2 (map (specify Y (not (Q))) r1))
;;         (define s1 (map (specify X (P)) and-symmetric))
;;         (define s2 (map (specify Y (not (Q))) s1))
;;         (define sr1 (map (specify X (not (Q))) and-elim))
;;         (define sr2 (map (specify Y (P)) sr1))
;;         (define Abs-1 (map (specify X (and (P) (not (Q)))) Abs))
;;         (define RAA-target (map (specify X (not (Q))) RAA))
;;         (define DN-target (map (specify X (Q)) DN))
;;         (define and-intro-p-notq (map (specify Y (not (Q))) (map (specify X (P)) and-intro)))
;;         (define and-intro-p-notq-premise-1
;;           (map (specify Y (not (and (P) (not (Q)))))
;;                (map (specify X (and (P) (not (Q)))) and-intro)))

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
;;         (define and-intro-p-q (map (specify Y (Q)) (map (specify X (P)) and-intro)))
;;         (define and-intro-p-r (map (specify Y (R)) (map (specify X (P)) and-intro)))
;;         (define or-intro-p-q-p-r-1 (map (specify Y (and (P) (R))) (map (specify X (and (P) (Q))) or-intro-left)))
;;         (define or-intro-p-q-p-r-2 (map (specify Y (and (P) (R))) (map (specify X (and (P) (Q))) or-intro-right)))
;;         (define p (apply (map (specify Y (or (Q) (R))) (map (specify X (P)) and-elim-left))
;;                          premise-1))
;;         (define reversed (apply (map (specify Y (or (Q) (R))) (map (specify X (P)) and-symmetric))
;;                                 premise-1))

;;         (define or-elim-target
;;           (let ()
;;             (define a (map (specify X (Q)) or-elim))
;;             (define b (map (specify Y (R)) a))
;;             (define c (map (specify Z (or (and (P) (Q)) (and (P) (R)))) b))
;;             c))

;;         (define or-q-r (apply (map (specify X (or (Q) (R))) (map (specify Y (P)) and-elim-left)) reversed))

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
;;           (map (specify Y (not Q)) (map (specify X (not P)) and-elim-left)))

;;         (define and-elim-left-p-notp
;;           (map (specify Y (not P)) (map (specify X P) and-elim-left)))

;;         (define and-elim-right-p-notp
;;           (map (specify Y (not P)) (map (specify X P) and-elim-right)))

;;         (define and-intro-p-notp
;;           (map (specify Y (not P)) (map (specify X P) and-intro)))

;;         (define abs-p
;;           (map (specify X P) Abs))

;;         (define raa1-rule (map (specify X (and (not P) (not Q))) RAA))

;;         (define and-intro-notp-notq
;;           (= (map (specify Y (not Q)) (map (specify X (not P)) and-intro))
;;              (if (not P) (if (not Q) (and (not P) (not Q))))))

;;         (define and-intro-1
;;           (= (map (specify Y (not (and (not P) (not Q)))) (map (specify X (and (not P) (not Q))) and-intro))
;;              (if (and (not P) (not Q))
;;                  (if (not (and (not P) (not Q)))
;;                      (and (and (not P) (not Q)) (not (and (not P) (not Q))))))))

;;         (define abs-1
;;           (= (map (specify X (and (not P) (not Q))) Abs)
;;              (if (and (and (not P) (not Q)) (not (and (not P) (not Q)))) (false))))

;;         (define notq-raa
;;           (= (map (specify X (not Q)) RAA)
;;              (if (if (not Q) (false)) (not (not Q)))))

;;         (define DN-q
;;           (map (specify X Q) DN))

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


;; ;; (test-case
;; ;;  ;;
;; ;;  ;; Check bad modus ponens.
;; ;;  ;;

;; ;;  '(begin
;; ;;     (define and-elim
;; ;;       (axiom (if (and X Y) X)))
;; ;;     (define and-symmetric
;; ;;       (axiom (if (and X Y) (and Y X))))

;; ;;     (define thm
;; ;;       (let ()
;; ;;         (define thm2
;; ;;           (let ()
;; ;;             (define thm3
;; ;;               (let ((t (and X Y Z)))
;; ;;                 (apply and-elim t)))
;; ;;             thm3))
;; ;;         thm2))

;; ;;     )

;; ;;  (olesya:return:fail
;; ;;   `(non-matching-modus-ponens
;; ;;     ((context:
;; ;;       argument:
;; ;;       (and X Y Z)
;; ;;       implication:
;; ;;       (if (and X Y) X)
;; ;;       endcontext:))
;; ;;     (thm3 thm2 thm))))


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
;;       (axiom (if t (if (forall x B) (map (rule x t) B)))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (rule x c) (forall c Q)))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (rule t c) (exists c B))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (rule x (exists x B)) B))))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     ;;
;;     ;;  Theorem:
;;     ;;

;;     (define de-morgan-&
;;       (let ()
;;         (define contr-1a (map (specify P (and P Q)) Abs))
;;         (define abs-1a (map (specify P Q) Abs))
;;         (define and-intro-xy (map (specify Q Y) (map (specify P X) and-intro)))
;;         (define and-intro-andpq (map (specify Y (not (and P Q)))
;;                                      (map (specify X (and P Q)) and-intro-xy)))
;;         (define or-intro-right-xy (map (specify Q Y) (map (specify P X) or-intro-right)))
;;         (define or-intro-right-notq (map (specify Y (not Q)) (map (specify X (not P)) or-intro-right-xy)))
;;         (define or-intro-left-xy (map (specify Q Y) (map (specify P X) or-intro-left)))
;;         (define or-intro-left-notq (map (specify Y (not Q)) (map (specify X (not P)) or-intro-left-xy)))
;;         (define raa-notq (map (specify P Q) RAA))
;;         (define ret (map (specify R (or (not P) (not Q))) (map (specify Q (not P)) or-elim)))

;;         (let ((premise (not (and P Q))))

;;           (define x
;;             (let ((p P))

;;               (define q->false
;;                 (let ((q Q))
;;                   (define andpq
;;                     (apply and-intro p q))

;;                   (define contr-1a-input
;;                     (apply and-intro-andpq andpq premise))

;;                   (apply contr-1a contr-1a-input)))

;;               (define notq->ret
;;                 (let ((notq (not Q)))
;;                   (apply or-intro-right-notq notq)))

;;               (define notq
;;                 (apply raa-notq q->false))

;;               (apply notq->ret notq)))

;;           (define y
;;             (let ((notp (not P)))
;;               (apply or-intro-left-notq notp)))

;;           (define z
;;             (apply ret LEM x y))

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
;;       (axiom (if t (if (forall x B) (map (axiom (rule x t)) (axiom B))))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (axiom (rule x c))
;;                                                   (axiom (forall c Q))))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (axiom (rule t c)) (axiom (exists c B)))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (axiom (rule x (exists x B))) (axiom B)))))

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
;;           (= (map (specify t (exists (x) (not P)))
;;                   (map (specify x (x))
;;                        (map (specify B P)
;;                             universal-instantiation)))
;;              (if (exists (x) (not P))
;;                  (if (forall (x) P)
;;                      (map (axiom (rule (x) (exists (x) (not P))))
;;                           (axiom P))))))

;;         (define existential-instantiation-1
;;           (= (map (specify x (x)) (map (specify B (not P)) existential-instantiation))
;;              (if (exists (x) (not P))
;;                  (map (axiom (rule (x) (exists (x) (not P))))
;;                       (axiom (not P))))))

;;         (define and-intro-1
;;           (= (map (specify Q (not P))
;;                   (map (specify P P)
;;                        and-intro))
;;              (if P
;;                  (if (not P)
;;                      (and P
;;                           (not P))))))

;;         (define abs-1
;;           (= (map (specify P P) Abs)
;;              (if (and P
;;                       (not P))
;;                  (false))))

;;         (define raa-1
;;           (= (map (specify P (exists (x) (not P))) RAA)
;;              (if (if (exists (x) (not P)) (false))
;;                  (not (exists (x) (not P))))))

;;         (let ((premise (forall (x) P)))

;;           (define conclusion->false
;;             (let ((not-conclusion (exists (x) (not P))))

;;               (define c not-conclusion)

;;               (define instance/text
;;                 (= (apply existential-instantiation-1 not-conclusion)
;;                    (map (axiom (rule (x) (exists (x) (not P))))
;;                         (axiom (not P)))))

;;               (define instance
;;                 (= (eval instance/text)
;;                    (not P)))

;;               (define instance-2/text
;;                 (= (apply universal-instantiation-1 c premise)
;;                    (map (axiom (rule (x) (exists (x) (not P))))
;;                         (axiom P))))

;;               (define instance-2
;;                 (= (eval instance-2/text)
;;                    P))

;;               (define both-instances
;;                 (apply and-intro-1 instance-2 instance))

;;               (define false
;;                 (= (apply abs-1 both-instances)
;;                    (false)))

;;               false))

;;           (apply raa-1 conclusion->false))))

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
;;       (axiom (if t (if (forall x B) (map (axiom (rule x t)) (axiom B))))))

;;     (define universal-generalization
;;       (axiom (if c (if (if x Q) (if (if x c) (map (axiom (rule x c))
;;                                                   (axiom (forall c Q))))))))

;;     (define existential-generalization
;;       (axiom (if c (if B (map (axiom (rule t c)) (axiom (exists c B)))))))

;;     (define existential-instantiation
;;       (axiom (if (exists x B) (map (axiom (rule x (exists x B))) (axiom B)))))

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
;;           (= (map (specify t P)
;;                   (map (specify x (x))
;;                        (map (specify B (not P))
;;                             universal-instantiation)))
;;              (if P
;;                  (if (forall (x) (not P))
;;                      (map (axiom (rule (x) P)) (axiom (not P)))))))

;;         (define existential-instantiation-1
;;           (= (map (specify x (x)) (map (specify B P) existential-instantiation))
;;              (if (exists (x) P)
;;                  (map (axiom (rule (x) (exists (x) P))) (axiom P)))))

;;         (define and-intro-1
;;           (= (map (specify Q (not P))
;;                   (map (specify P P)
;;                        and-intro))
;;              (if P
;;                  (if (not P)
;;                      (and P
;;                           (not P))))))

;;         (define abs-1
;;           (= (map (specify P P) Abs)
;;              (if (and P
;;                       (not P))
;;                  (false))))

;;         (define raa-1
;;           (= (map (specify P (forall (x) (not P))) RAA)
;;              (if (if (forall (x) (not P)) (false))
;;                  (not (forall (x) (not P))))))

;;         (let ((premise (exists (x) P)))

;;           (define conclusion->false
;;             (let ((not-conclusion (forall (x) (not P))))

;;               (define instance-2/text
;;                 (= (apply existential-instantiation-1 premise)
;;                    (map (axiom (rule (x) (exists (x) P))) (axiom P))))

;;               (define instance-2
;;                 (= (eval instance-2/text)
;;                    P))

;;               (define instance/text
;;                 (= (apply universal-instantiation-1 instance-2 not-conclusion)
;;                    (map (axiom (rule (x) P)) (axiom (not P)))))

;;               (define instance
;;                 (= (eval instance/text)
;;                    (not P)))

;;               (define both-instances
;;                 (apply and-intro-1 instance-2 instance))

;;               (define false
;;                 (= (apply abs-1 both-instances)
;;                    (false)))

;;               false))

;;           (apply raa-1 conclusion->false))))

;;     (= theorem
;;        (if (exists (x) P)
;;            (not (forall (x) (not P)))))

;;     )

;;  'ignore-ok)


;; ;; (test-case
;; ;;  ;;
;; ;;  ;;  Basic proof with quantifiers.
;; ;;  ;;  Taken from "First Order Logic and Automated Theorem Proving",
;; ;;  ;;     second edition, by Melvin Fitting, page 154.
;; ;;  ;;

;; ;;  '(begin

;; ;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;     ;;
;; ;;     ;;  Propositional axioms:
;; ;;     ;;

;; ;;     (define MP ;; The "modus ponens" law.
;; ;;       (axiom (if P (if (if P Q) Q))))
;; ;;     (define DN ;; The "double negation" law.
;; ;;       (axiom (if (not (not P)) P)))
;; ;;     (define EFQ ;; The "ex-falso-quodlibet" law.
;; ;;       (axiom (if (false) P)))
;; ;;     (define Abs ;; The "absurdity rule" law.
;; ;;       (axiom (if (and P (not P)) (false))))
;; ;;     (define RAA ;; The "reductio ad absurdum" law.
;; ;;       (axiom (if (if P (false)) (not P))))
;; ;;     (define CP ;; The "contraposition" law.
;; ;;       (axiom (if (if P Q) (if (not P) (not Q)))))
;; ;;     (define LEM ;; The "law of excluded middle".
;; ;;       (axiom (or P (not P))))

;; ;;     (define and-intro
;; ;;       (axiom (if P (if Q (and P Q)))))
;; ;;     (define and-elim-left
;; ;;       (axiom (if (and P Q) P)))
;; ;;     (define and-elim-right
;; ;;       (axiom (if (and P Q) Q)))

;; ;;     (define or-intro-left
;; ;;       (axiom (if P (or P Q))))
;; ;;     (define or-intro-right
;; ;;       (axiom (if Q (or P Q))))
;; ;;     (define or-elim
;; ;;       (axiom (if (or P Q) (if (if P R) (if (if Q R) R)))))

;; ;;     (define implication-intro
;; ;;       (axiom (if (or (not P) Q) (if P Q))))
;; ;;     (define implication-elim
;; ;;       (axiom (if (if P Q) (or (not P) Q))))

;; ;;     (define not-intro
;; ;;       RAA)
;; ;;     (define not-elim
;; ;;       DN)

;; ;;     (define true-intro
;; ;;       (axiom (if P (true))))
;; ;;     (define true-elim
;; ;;       (axiom (if (not (true)) (false))))
;; ;;     (define false-intro
;; ;;       Abs)
;; ;;     (define false-elim
;; ;;       EFQ)

;; ;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;     ;;
;; ;;     ;;  Quantifier rules:
;; ;;     ;;

;; ;;     (define universal-instantiation
;; ;;       (axiom (if t (if (forall x B) (map (axiom (rule x t)) (axiom B))))))

;; ;;     (define universal-generalization
;; ;;       (axiom (if c (if (if x Q) (if (if x c) (map (axiom (rule x c))
;; ;;                                                   (axiom (forall c Q))))))))

;; ;;     (define existential-generalization
;; ;;       (axiom (if c (if B (map (axiom (rule t c)) (axiom (exists c B)))))))

;; ;;     (define existential-instantiation
;; ;;       (axiom (if (exists x B) (map (axiom (rule x (exists x B))) (axiom B)))))

;; ;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;     ;;
;; ;;     ;;  Useful theorems:
;; ;;     ;;

;; ;;     (define de-morgan-/
;; ;;       (axiom (if (not (or P Q)) (and (not P) (not Q)))))

;; ;;     (define if-negation
;; ;;       (axiom (if (not (if P Q)) (and P (not Q)))))

;; ;;     (define universal-negation
;; ;;       (axiom (if (not (forall (x) P))
;; ;;                  (exists (x) (not P)))))

;; ;;     (define existential-negation
;; ;;       (axiom (if (not (exists (x) P))
;; ;;                  (forall (x) (not P)))))

;; ;;     (define universal->existential
;; ;;       (axiom (if (forall (x) P)
;; ;;                  (not (exists (x) (not P))))))

;; ;;     (define existential->universal
;; ;;       (axiom (if (exists (x) P)
;; ;;                  (not (forall (x) (not P))))))

;; ;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;     ;;
;; ;;     ;;  Theorem:
;; ;;     ;;

;; ;;     (define theorem
;; ;;       (let ()

;; ;;         (define if-negation-1
;; ;;           (=  (map (specify Q (or (exists (x) (P (x))) (forall (x) (Q (x)))))
;; ;;                    (map (specify P (forall (x) (or (P (x)) (Q (x))))) if-negation))
;; ;;               (if (not (if (forall (x) (or (P (x)) (Q (x))))
;; ;;                            (or (exists (x) (P (x))) (forall (x) (Q (x))))))
;; ;;                   (and (forall (x) (or (P (x)) (Q (x))))
;; ;;                        (not (or (exists (x) (P (x))) (forall (x) (Q (x)))))))))

;; ;;         (define and-elim-left-1
;; ;;           (map (specify Q (not (or (exists (x) (P (x)))
;; ;;                               (forall (x) (Q (x))))))
;; ;;                (map (specify P (forall (x) (or (P (x)) (Q (x))))) and-elim-left)))

;; ;;         (define and-elim-right-1
;; ;;           (map (specify Q (not (or (exists (x) (P (x)))
;; ;;                               (forall (x) (Q (x))))))
;; ;;                (map (specify P (forall (x) (or (P (x)) (Q (x))))) and-elim-right)))

;; ;;         (define de-morgan-/-1
;; ;;           (=

;; ;;            (map (specify Q (forall (x) (Q (x))))
;; ;;                 (map (specify P (exists (x) (P (x)))) de-morgan-/))

;; ;;            (if (not (or (exists (x) (P (x)))
;; ;;                         (forall (x) (Q (x)))))
;; ;;                (and (not (exists (x) (P (x))))
;; ;;                     (not (forall (x) (Q (x))))))))

;; ;;         (define and-elim-left-2
;; ;;           (map (specify Q (not (forall (x) (Q (x)))))
;; ;;                (map (specify P (not (exists (x) (P (x))))) and-elim-left)))

;; ;;         (define and-elim-right-2
;; ;;           (map (specify Q (not (forall (x) (Q (x)))))
;; ;;                (map (specify P (not (exists (x) (P (x))))) and-elim-right)))

;; ;;         (define negate-forall-q
;; ;;           (= (map (specify P (Q (x))) universal-negation)
;; ;;              (if (not (forall (x) (Q (x))))
;; ;;                  (exists (x) (not (Q (x)))))))

;; ;;         (define existential-instantiation-1
;; ;;           (= (map (specify x (x)) (map (specify B (not (Q (x)))) existential-instantiation))
;; ;;              (if (exists (x) (not (Q (x))))
;; ;;                  (map (axiom (rule (x) (exists (x) (not (Q (x))))))
;; ;;                       (axiom (not (Q (x))))))))

;; ;;         (define negate-exists-p
;; ;;           (= (map (specify P (P (x))) existential-negation)
;; ;;              (if (not (exists (x) (P (x))))
;; ;;                  (forall (x) (not (P (x)))))))

;; ;;         (define universal-instantiation-1
;; ;;           (= (map (specify t (exists (x) (not (Q (x)))))
;; ;;                   (map (specify x (x))
;; ;;                        (map (specify B (not (P (x)))) universal-instantiation)))
;; ;;              (if (exists (x) (not (Q (x))))
;; ;;                  (if (forall (x) (not (P (x))))
;; ;;                      (map (axiom (rule (x) (exists (x) (not (Q (x))))))
;; ;;                           (axiom (not (P (x)))))))))

;; ;;         (define universal-instantiation-2
;; ;;           (= (map (specify t (exists (x) (not (Q (x)))))
;; ;;                   (map (specify x (x))
;; ;;                        (map (specify B (or (P (x)) (Q (x))))
;; ;;                             universal-instantiation)))
;; ;;              (if (exists (x) (not (Q (x))))
;; ;;                  (if (forall (x) (or (P (x)) (Q (x))))
;; ;;                      (map (axiom (rule (x) (exists (x) (not (Q (x))))))
;; ;;                           (axiom (or (P (x)) (Q (x)))))))))

;; ;;         (define and-intro-1
;; ;;           (map (specify Q (not (P (exists (x) (not (Q (x)))))))
;; ;;                (map (specify P (P (exists (x) (not (Q (x)))))) and-intro)))

;; ;;         (define abs-p<c>
;; ;;           (map (specify P (P (exists (x) (not (Q (x)))))) Abs))

;; ;;         (define and-intro-2
;; ;;           (map (specify Q (not (Q (exists (x) (not (Q (x)))))))
;; ;;                (map (specify P (Q (exists (x) (not (Q (x)))))) and-intro)))

;; ;;         (define abs-q<c>
;; ;;           (map (specify P (Q (exists (x) (not (Q (x)))))) Abs))

;; ;;         (define or-elim-1
;; ;;           (map (specify R (false))
;; ;;                (map (specify Q (Q (exists (x) (not (Q (x))))))
;; ;;                     (map (specify P (P (exists (x) (not (Q (x))))))
;; ;;                          or-elim))))

;; ;;         (= or-elim-1
;; ;;            (if (or (P (exists (x) (not (Q (x)))))
;; ;;                    (Q (exists (x) (not (Q (x))))))
;; ;;                (if (if (P (exists (x) (not (Q (x))))) (false))
;; ;;                    (if (if (Q (exists (x) (not (Q (x))))) (false))
;; ;;                        (false)))))

;; ;;         (define raa-final
;; ;;           (map (specify P (not (if (forall (x) (or (P (x)) (Q (x))))
;; ;;                               (or (exists (x) (P (x))) (forall (x) (Q (x)))))))
;; ;;                RAA))

;; ;;         (define dn-final
;; ;;           (map (specify P (if (forall (x) (or (P (x)) (Q (x)))) (or (exists (x) (P (x))) (forall (x) (Q (x))))))
;; ;;                DN))

;; ;;         (define refutation
;; ;;           (let ((resolution-1
;; ;;                  (not (if (forall (x) (or (P (x)) (Q (x))))
;; ;;                           (or (exists (x) (P (x)))
;; ;;                               (forall (x) (Q (x))))))))

;; ;;             (define statement
;; ;;               (= (apply if-negation-1 resolution-1)
;; ;;                  (and (forall (x) (or (P (x)) (Q (x))))
;; ;;                       (not (or (exists (x) (P (x))) (forall (x) (Q (x))))))))

;; ;;             (define resolution-2
;; ;;               (=  (apply and-elim-left-1 statement)
;; ;;                   (forall (x) (or (P (x)) (Q (x))))))

;; ;;             (define resolution-3
;; ;;               (= (apply and-elim-right-1 statement)
;; ;;                  (not (or (exists (x) (P (x))) (forall (x) (Q (x)))))))

;; ;;             (define de-morganed-1
;; ;;               (= (apply de-morgan-/-1 resolution-3)
;; ;;                  (and (not (exists (x) (P (x)))) (not (forall (x) (Q (x)))))))

;; ;;             (define resolution-4
;; ;;               (= (apply and-elim-left-2 de-morganed-1)
;; ;;                  (not (exists (x) (P (x))))))

;; ;;             (define resolution-5
;; ;;               (= (apply and-elim-right-2 de-morganed-1)
;; ;;                  (not (forall (x) (Q (x))))))

;; ;;             (define exists-notq
;; ;;               (= (apply negate-forall-q resolution-5)
;; ;;                  (exists (x) (not (Q (x))))))

;; ;;             (define resolution-6/text
;; ;;               (= (apply existential-instantiation-1 exists-notq)
;; ;;                  (map (axiom (rule (x) (exists (x) (not (Q (x))))))
;; ;;                       (axiom (not (Q (x)))))))

;; ;;             (define resolution-6
;; ;;               (= (eval resolution-6/text)
;; ;;                  (not (Q (exists (x) (not (Q (x))))))))

;; ;;             (= 1 2)

;; ;;             (define forall-notp
;; ;;               (= (apply negate-exists-p resolution-4)
;; ;;                  (forall (x) (not (P (x))))))

;; ;;             (define resolution-7/text
;; ;;               (= (apply universal-instantiation-1 exists-notq forall-notp)
;; ;;                  (map (axiom (rule (x) (exists (x) (not (Q (x))))))
;; ;;                       (axiom (not (P (x)))))))

;; ;;             (define resolution-7
;; ;;               (= (eval resolution-7/text)
;; ;;                  (not (P (exists (x) (not (Q (x))))))))

;; ;;             (define resolution-8/text
;; ;;               (= (apply universal-instantiation-2 exists-notq resolution-2)
;; ;;                  (map (axiom (rule (x) (exists (x) (not (Q (x))))))
;; ;;                       (axiom (or (P (x)) (Q (x)))))))

;; ;;             (define resolution-8
;; ;;               (= (eval resolution-8/text)
;; ;;                  (or (P (exists (x) (not (Q (x))))) (Q (exists (x) (not (Q (x))))))))

;; ;;             (define first-case
;; ;;               (let ((p<c> (P (exists (x) (not (Q (x)))))))

;; ;;                 (define tuple
;; ;;                   (= (apply and-intro-1 p<c> resolution-7)
;; ;;                      (and (P (exists (x) (not (Q (x)))))
;; ;;                           (not (P (exists (x) (not (Q (x)))))))))

;; ;;                 (define false
;; ;;                   (apply abs-p<c> tuple))

;; ;;                 false))

;; ;;             (define second-case
;; ;;               (let ((resolution-10 (Q (exists (x) (not (Q (x)))))))

;; ;;                 (define tuple
;; ;;                   (apply and-intro-2 resolution-10 resolution-6))

;; ;;                 (define false
;; ;;                   (apply abs-q<c> tuple))

;; ;;                 false))

;; ;;             ;; (= second-case 0)

;; ;;             (define resolution-11
;; ;;               (apply or-elim-1 resolution-8 first-case second-case))

;; ;;             (= resolution-11 (false))

;; ;;             resolution-11))

;; ;;         (define negated
;; ;;           (apply raa-final refutation))

;; ;;         (define final
;; ;;           (apply dn-final negated))

;; ;;         final))

;; ;;     (= theorem
;; ;;        (if (forall (x) (or (P (x)) (Q (x))))
;; ;;            (or (exists (x) (P (x))) (forall (x) (Q (x))))))

;; ;;     )

;; ;;  'ignore-ok)
