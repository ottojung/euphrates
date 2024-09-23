

(define (test-case program expected-mapping)
  (define result/wrapped
    (lesya:interpret program))

  (define-values (type result)
    (values (car result/wrapped) (cdr result/wrapped)))

  (define actual
    (cond
     ((equal? expected-mapping 'ignore-ok)
      (assert= type 'ok)
      #f)
     ((equal? expected-mapping 'ignore-error)
      (assert= type 'error)
      #f)
     ((equal? type 'error)
      result/wrapped)
     ((equal? type 'ok)
      (map (lambda (p) (list (car p) (cdr p)))
           (euphrates:list-sort
            (hashmap->alist result)
            (lambda (a b)
              (string<? (~s (car a)) (~s (car b)))))))

     (else
      (raisu-fmt 'unknown-type "Unknown type of result: ~s" type))))

  (when actual
    (unless (equal? actual expected-mapping)
      (debugs actual)
      (exit 1))

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
      (axiom (if (P) (Q))))
    (define y
      (axiom (if (Q) (R))))

    (define z
      (let ((p (P)))
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
      (let ((q (Q)))
        (let ((p (P)))
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
    (define and-intro
      (axiom (if X (if Y (and X Y)))))

    (define x
      (let ()
        (define and-intro-p-q
          (beta ((beta (and-intro X) (P)) Y) (Q)))

        (let ((y (P))
              (w (Q)))
          (apply (apply and-intro-p-q y) w))))

    )

 `((and-elim (if (and X Y) X))
   (and-intro (if X (if Y (and X Y))))
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
      (let ((m (and (P) (Q))))
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
      (let ((m (and (P) (Q))))
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

 '(define x (let ((p (P))) p))

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
    (define and-intro
      (axiom (if X (if Y (and X Y)))))
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and X (not X)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if X (false)) (not X))))
    (define DN ;; The "double negation" law.
      (axiom (if (not (not X)) X)))

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
        (define RAA-target (beta (RAA X) (and (P) (not (Q)))))
        (define and-intro-q-notq (beta ((beta (and-intro X) (Q)) Y) (not (Q))))

        (define tofalse
          (let ((m (and (P) (not (Q)))))
            (define p (apply r2 m))
            (define swapped (apply s2 m))
            (define notq (apply sr2 swapped))
            (define q (apply premise-1 p))
            (define q-and-notq (apply (apply and-intro-q-notq q) notq))
            (define bot (apply Abs-q q-and-notq))
            bot))

        (apply RAA-target tofalse)))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim (if (and X Y) X))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (premise-1 (if (P) (Q)))
   (x (not (and (P) (not (Q)))))))


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
    (define and-intro
      (axiom (if X (if Y (and X Y)))))
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and X (not X)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if X (false)) (not X))))
    (define DN ;; The "double negation" law.
      (axiom (if (not (not X)) X)))

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
        (define RAA-target (beta (RAA X) (and (P) (not (Q)))))
        (define and-intro-q-notq (beta ((beta (and-intro X) (Q)) Y) (not (Q))))

        (define tofalse
          (let ((m (and (P) (not (Q)))))
            (define p (apply r2 m))
            (define swapped (apply s2 m))
            (define notq (apply sr2 swapped))
            (define q (apply premise-1 p))
            (define q-and-notq (apply (apply and-intro-q-notq q) notq))
            (define bot (apply Abs-q q-and-notq))
            bot))

        (apply RAA-target tofalse)))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim (if (and X Y) X))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (premise-1 (if (P) (Q)))
   (x (not (and (P) (not (Q)))))))


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
    (define and-intro
      (axiom (if X (if Y (and X Y)))))
    (define EFQ ;; The "ex-falso-quodlibet" law.
      (axiom (if (false) X)))
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and X (not X)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if X (false)) (not X))))
    (define DN ;; The "double negation" law.
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
        (define Abs-1 (beta (Abs X) (and (P) (not (Q)))))
        (define RAA-target (beta (RAA X) (not (Q))))
        (define DN-target (beta (DN X) (Q)))
        (define and-intro-p-notq (beta ((beta (and-intro X) (P)) Y) (not (Q))))
        (define and-intro-p-notq-premise-1 (beta ((beta (and-intro X) (and (P) (not (Q)))) Y) (not (and (P) (not (Q))))))

        (let ((p (P)))
          (define contr1
            (let ((notq (not (Q))))
              (define and-p-notq (apply (apply and-intro-p-notq p) notq))
              ;; (define contr1 (and and-p-notq premise-1))
              (define contr1 (apply (apply and-intro-p-notq-premise-1 and-p-notq) premise-1))
              (define abs1 (apply Abs-1 contr1))
              abs1))

          (define nnq (apply RAA-target contr1))
          (apply DN-target nnq))))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (EFQ (if (false) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim (if (and X Y) X))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (premise-1 (not (and (P) (not (Q)))))
   (x (if (P) (Q)))))


(test-case
 ;;
 ;; Basic case-proof. (Proving distributivity of conjunction over disjunction).
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 9.
 ;; Note: the proof there seems to be wrong, actually.
 ;;

 '(begin
    (define or-intro-left
      (axiom (if X (or X Y))))
    (define or-intro-right
      (axiom (if Y (or X Y))))
    (define or-symmetric
      (axiom (if (or X Y) (or Y X))))
    (define or-elim
      (axiom (if (or X Y) (if (if X Z) (if (if Y Z) Z)))))
    (define and-intro
      (axiom (if X (if Y (and X Y)))))
    (define and-elim-left
      (axiom (if (and X Y) X)))
    (define and-elim-right
      (axiom (if (and X Y) Y)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))
    (define EFQ ;; The "ex-falso-quodlibet" law.
      (axiom (if (false) X)))
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and X (not X)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if X (false)) (not X))))
    (define DN ;; The "double negation" law.
      (axiom (if (not (not X)) X)))

    (define premise-1
      (axiom (and (P) (or (Q) (R)))))

    (define x
      (let ()
        (define and-intro-p-q (beta ((beta (and-intro X) (P)) Y) (Q)))
        (define and-intro-p-r (beta ((beta (and-intro X) (P)) Y) (R)))
        (define or-intro-p-q-p-r-1 (beta ((beta (or-intro-left X) (and (P) (Q))) Y) (and (P) (R))))
        (define or-intro-p-q-p-r-2 (beta ((beta (or-intro-right X) (and (P) (Q))) Y) (and (P) (R))))
        (define p (apply (beta ((beta (and-elim-left X) (P)) Y) (or (Q) (R)))
                         premise-1))
        (define reversed (apply (beta ((beta (and-symmetric X) (P)) Y) (or (Q) (R)))
                                premise-1))

        (define or-elim-target
          (let ()
            (define a (beta (or-elim X) (Q)))
            (define b (beta (a Y) (R)))
            (define c (beta (b Z) (or (and (P) (Q)) (and (P) (R)))))
            c))

        (define or-q-r (apply (beta ((beta (and-elim-left Y) (P)) X) (or (Q) (R)))
                              reversed))

        (define q-><p-&-q/p-&-r>
          (let ((q (Q)))
            (define p-and-q
              (apply (apply and-intro-p-q p) q))

            (apply or-intro-p-q-p-r-1 p-and-q)))

        (define r-><p-&-q/p-&-r>
          (let ((r (R)))
            (define p-and-r
              (apply (apply and-intro-p-r p) r))

            (apply or-intro-p-q-p-r-2 p-and-r)))

        (define or-elim-target-1
          (apply or-elim-target or-q-r))

        (define or-elim-target-2
          (apply or-elim-target-1 q-><p-&-q/p-&-r>))

        (define or-elim-target-3
          (apply or-elim-target-2 r-><p-&-q/p-&-r>))

        or-elim-target-3))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (EFQ (if (false) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim-left (if (and X Y) X))
   (and-elim-right (if (and X Y) Y))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (or-elim
    (if (or X Y) (if (if X Z) (if (if Y Z) Z))))
   (or-intro-left (if X (or X Y)))
   (or-intro-right (if Y (or X Y)))
   (or-symmetric (if (or X Y) (or Y X)))
   (premise-1 (and (P) (or (Q) (R))))
   (x (or (and (P) (Q)) (and (P) (R))))))


(test-case
 ;;
 ;; Derivation of ((P /\ ~P) -> Q) without EFQ law.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 11.
 ;;

 '(begin
    (define or-intro-left
      (axiom (if X (or X Y))))
    (define or-intro-right
      (axiom (if Y (or X Y))))
    (define or-symmetric
      (axiom (if (or X Y) (or Y X))))
    (define or-elim
      (axiom (if (or X Y) (if (if X Z) (if (if Y Z) Z)))))
    (define and-intro
      (axiom (if X (if Y (and X Y)))))
    (define and-elim-left
      (axiom (if (and X Y) X)))
    (define and-elim-right
      (axiom (if (and X Y) Y)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))
    ;; (define EFQ ;; The "ex-falso-quodlibet" law.
    ;;   (axiom (if (false) X)))
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and X (not X)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if X (false)) (not X))))
    (define DN ;; The "double negation" law.
      (axiom (if (not (not X)) X)))

    (define x
      (let ()

        (define and-elim-left-notp-notq
          (beta ((beta (and-elim-left X) (not P)) Y) (not Q)))

        (define and-elim-left-p-notp
          (beta ((beta (and-elim-left X) P) Y) (not P)))

        (define and-elim-right-p-notp
          (beta ((beta (and-elim-right X) P) Y) (not P)))

        (define and-intro-p-notp
          (beta ((beta (and-intro X) P) Y) (not P)))

        (define abs-p
          (beta (Abs X) P))

        (define raa1-rule (beta (RAA X) (and (not P) (not Q))))

        (define and-intro-notp-notq
          (= (beta ((beta (and-intro X) (not P)) Y) (not Q))
             (if (not P) (if (not Q) (and (not P) (not Q))))))

        (define and-intro-1
          (= (beta ((beta (and-intro X) (and (not P) (not Q))) Y)
                   (not (and (not P) (not Q))))
             (if (and (not P) (not Q))
                 (if (not (and (not P) (not Q)))
                     (and (and (not P) (not Q)) (not (and (not P) (not Q))))))))

        (define abs-1
          (= (beta (Abs X) (and (not P) (not Q)))
             (if (and (and (not P) (not Q)) (not (and (not P) (not Q)))) (false))))

        (define notq-raa
          (= (beta (RAA X) (not Q))
             (if (if (not Q) (false)) (not (not Q)))))

        (define DN-q
          (alpha (DN X) Q))

        (let ((p-and-notp (and P (not P))))

          (define p (apply and-elim-left-p-notp p-and-notp))
          (define notp (apply and-elim-right-p-notp p-and-notp))

          (define false1
            (let ((not-p-and-not-q (and (not P) (not Q))))
              (define and-p-notp (apply (apply and-intro-p-notp p) notp))
              (apply abs-p and-p-notp)))

          (define raa1
            (= (apply raa1-rule false1)
               (not (and (not P) (not Q)))))

          (define not<q>->false
            (let ((notq (not Q)))
              (define and-p-notp
                (= (apply (apply and-intro-notp-notq notp) notq)
                   (and (not P) (not Q))))

              (define y
                (= (apply (apply and-intro-1 and-p-notp) raa1)
                   (and (and (not P) (not Q)) (not (and (not P) (not Q))))))

              (define yabs
                (= (apply abs-1 y)
                   (false)))

              yabs))

          (= not<q>->false
             (if (not Q) (false)))

          (define not<not<q>>
            (= (apply notq-raa not<q>->false)
               (not (not Q))))

          (apply DN-q not<not<q>>))))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim-left (if (and X Y) X))
   (and-elim-right (if (and X Y) Y))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (or-elim
    (if (or X Y) (if (if X Z) (if (if Y Z) Z))))
   (or-intro-left (if X (or X Y)))
   (or-intro-right (if Y (or X Y)))
   (or-symmetric (if (or X Y) (or Y X)))
   (x (if (and P (not P)) Q))))


(test-case
 ;;
 ;; Test for unquote.
 ;;

 '(begin
    (define x
      (axiom (P)))

    (define y
      (axiom (and x ,x)))

    (define z
      (axiom (and x (unquote x))))

    )


 `((x (P))
   (y (and x (P)))
   (z (and x (P)))))


(test-case
 ;;
 ;; Basic proof with disjunction. With `eval` style.
 ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))

    (define r1 (map (if X (P)) and-elim))
    ;; (define r2 (map (if Y (Q)) r1)) ;; equivalent to one below:
    (define r2 (eval (axiom (map (if Y (Q)) ,r1))))

    (define x
      (let ((m (and (P) (Q))))
        (eval (list r2 m))))

    )

 `((and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
   (r1 (if (and (P) Y) (P)))
   (r2 (if (and (P) (Q)) (P)))
   (x (if (and (P) (Q)) (P)))))


(test-case
 ;;
 ;; Check error with `map` not on toplevel.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))

    (define r1 (map (if X (P)) and-elim))
    ;; (define r2 (map (if Y (Q)) r1)) ;; equivalent to one below:
    (define r2 (eval (axiom (map (if Y (Q)) ,r1))))

    (define x
      (let ((m (and (P) (Q))))
        (define r1-internal (map (if X (P)) and-elim))
        (eval (list r2 m))))

    )

 `(error only-allowed-on-top-level
         ("This operation is only allowed on toplevel: (let () (define-values (premise conclusion) (lesya:implication:destruct (quasiquote (if X (P))))) (unless (symbol? premise) (lesya:error (quote non-symbol-1-in-map) premise conclusion and-elim)) (lesya:language:beta-reduce and-elim premise conclusion)).")
         (r1-internal x)))


(test-case
 ;;
 ;; Check bad modus ponens.
 ;;

 '(begin
    (define and-elim
      (axiom (if (and X Y) X)))
    (define and-symmetric
      (axiom (if (and X Y) (and Y X))))

    (define thm
      (let ()
        (define thm2
          (let ()
            (define thm3
              (let ((t (and X Y Z)))
                (eval (list and-elim t))))
            thm3))
        thm2))

    )

 `(error non-matching-modus-ponens
         ((context:
           argument:
           (and X Y Z)
           implication:
           (if (and X Y) X)
           endcontext:))
         (thm3 thm2 thm)))


(test-case
 ;;
 ;; Derivation of ~(P /\ Q) -> ~P \/ ~Q (De-Morgan's law 1)
 ;;

 '(begin

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Propositional axioms:
    ;;

    (define MP ;; The "modus ponens" law.
      (axiom (if P (if (if P Q) Q))))
    (define DN ;; The "double negation" law.
      (axiom (if (not (not P)) P)))
    (define EFQ ;; The "ex-falso-quodlibet" law.
      (axiom (if (false) P)))
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and P (not P)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if P (false)) (not P))))
    (define CP ;; The "contraposition" law.
      (axiom (if (if P Q) (if (not P) (not Q)))))
    (define LEM ;; The "law of excluded middle".
      (axiom (or P (not P))))

    (define and-intro
      (axiom (if P (if Q (and P Q)))))
    (define and-elim-left
      (axiom (if (and P Q) P)))
    (define and-elim-right
      (axiom (if (and P Q) Q)))

    (define or-intro-left
      (axiom (if P (or P Q))))
    (define or-intro-right
      (axiom (if Q (or P Q))))
    (define or-elim
      (axiom (if (or P Q) (if (if P R) (if (if Q R) R)))))

    (define implication-intro
      (axiom (if (or (not P) Q) (if P Q))))
    (define implication-elim
      (axiom (if (if P Q) (or (not P) Q))))

    (define not-intro
      RAA)
    (define not-elim
      DN)

    (define true-intro
      (axiom (if P (true))))
    (define true-elim
      (axiom (if (not (true)) (false))))
    (define false-intro
      Abs)
    (define false-elim
      EFQ)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Quantifier rules:
    ;;

    (define universal-instantiation
      (axiom (if t (if (forall x B) (map B (if x t))))))

    (define universal-generalization
      (axiom (if c (if (if x Q) (if (if x c) (map (forall c Q) (if x c)))))))

    (define existential-generalization
      (axiom (if c (if B (map (exists c B) (if t c))))))

    (define existential-instantiation
      (axiom (if (exists x B) (map B (if x B)))))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;;  Theorem:
    ;;

    (define de-morgan-&
      (let ()
        (define contr-1a (map (if P (and P Q)) Abs))
        (define abs-1a (map (if P Q) Abs))
        (define and-intro-xy (map (if Q Y) (map (if P X) and-intro)))
        (define and-intro-andpq (map (if Y (not (and P Q)))
                                     (map (if X (and P Q)) and-intro-xy)))
        (define or-intro-right-xy (map (if Q Y) (map (if P X) or-intro-right)))
        (define or-intro-right-notq (map (if Y (not Q)) (map (if X (not P)) or-intro-right-xy)))
        (define or-intro-left-xy (map (if Q Y) (map (if P X) or-intro-left)))
        (define or-intro-left-notq (map (if Y (not Q)) (map (if X (not P)) or-intro-left-xy)))
        (define raa-notq (map (if P Q) RAA))
        (define ret (map (if R (or (not P) (not Q))) (map (if Q (not P)) or-elim)))

        (let ((premise (not (and P Q))))

          (define x
            (let ((p P))

              (define q->false
                (let ((q Q))
                  (define andpq
                    (eval (list and-intro p q)))

                  (define contr-1a-input
                    (eval (list and-intro-andpq andpq premise)))

                  (eval (list contr-1a contr-1a-input))))

              (define notq->ret
                (let ((notq (not Q)))
                  (eval (list or-intro-right-notq notq))))

              (define notq
                (eval (list raa-notq q->false)))

              (eval (list notq->ret notq))))

          (define y
            (let ((notp (not P)))
              (eval (list or-intro-left-notq notp))))

          (define z
            (eval (list ret LEM x y)))

          z)))

    )

 `((Abs (if (and P (not P)) (false)))
   (CP (if (if P Q) (if (not P) (not Q))))
   (DN (if (not (not P)) P))
   (EFQ (if (false) P))
   (LEM (or P (not P)))
   (MP (if P (if (if P Q) Q)))
   (RAA (if (if P (false)) (not P)))
   (and-elim-left (if (and P Q) P))
   (and-elim-right (if (and P Q) Q))
   (and-intro (if P (if Q (and P Q))))
   (de-morgan-&
    (if (not (and P Q)) (or (not P) (not Q))))
   (existential-generalization
    (if c (if B (map (exists c B) (if t c)))))
   (existential-instantiation
    (if (exists x B) (map B (if x B))))
   (false-elim (if (false) P))
   (false-intro (if (and P (not P)) (false)))
   (implication-elim (if (if P Q) (or (not P) Q)))
   (implication-intro (if (or (not P) Q) (if P Q)))
   (not-elim (if (not (not P)) P))
   (not-intro (if (if P (false)) (not P)))
   (or-elim
    (if (or P Q) (if (if P R) (if (if Q R) R))))
   (or-intro-left (if P (or P Q)))
   (or-intro-right (if Q (or P Q)))
   (true-elim (if (not (true)) (false)))
   (true-intro (if P (true)))
   (universal-generalization
    (if c
        (if (if x Q)
            (if (if x c) (map (forall c Q) (if x c))))))
   (universal-instantiation
    (if t (if (forall x B) (map B (if x t)))))))
