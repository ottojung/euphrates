
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

    (define x
      (let ((y (P))
            (w (Q)))
          (and y w)))

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

        (define tofalse
          (let ((m (and (P) (not (Q)))))
            (define p (apply r2 m))
            (define swapped (apply s2 m))
            (define notq (apply sr2 swapped))
            (define q (apply premise-1 p))
            (define q-and-notq (and q notq))
            (define bot (apply Abs-q q-and-notq))
            bot))

        (apply RAA-target tofalse)))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim (if (and X Y) X))
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
    (define Abs ;; The "absurdity rule" law.
      (axiom (if (and X (not X)) (false))))
    (define RAA ;; The "reductio ad absurdum" law.
      (axiom (if (if X (false)) (not X))))
    (define DN ;; The "double negation" law.
      (axiom (if (not (not X)) X)))

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

        (define tofalse
          (let ((m (and (P) (not (Q)))))
            (define p (apply r2 m))
            (define swapped (apply s2 m))
            (define notq (apply sr2 swapped))
            (define q (apply premise-1 p))
            (define q-and-notq (and q notq))
            (define bot (apply Abs-q q-and-notq))
            bot))

        (apply RAA-target tofalse)))

    )

 `((Abs (if (and X (not X)) (false)))
   (DN (if (not (not X)) X))
   (RAA (if (if X (false)) (not X)))
   (and-elim (if (and X Y) X))
   (and-symmetric (if (and X Y) (and Y X)))
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

        (let ((p (P)))
          (define contr1
            (let ((notq (not (Q))))
              (define and-p-notq (and p notq))
              (define contr1 (and and-p-notq premise-1))
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
      (axiom (if (and X Y) X)))
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
        (define p (apply (beta ((beta (and-elim X) (P)) Y) (or (Q) (R)))
                         premise-1))
        (define reversed (apply (beta ((beta (and-symmetric X) (P)) Y) (or (Q) (R)))
                                premise-1))

        (define or-elim-target
          (let ()
            (define a (beta (or-elim X) (Q)))
            (define b (beta (a Y) (R)))
            (define c (beta (b Z) (or (and (P) (Q)) (and (P) (R)))))
            c))

        (define or-q-r (apply (beta ((beta (and-elim Y) (P)) X) (or (Q) (R)))
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
   (and-elim-right (if (and X Y) X))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (or-elim
    (if (or X Y) (if (if X Z) (if (if Y Z) Z))))
   (or-intro-left (if X (or X Y)))
   (or-intro-right (if Y (or X Y)))
   (or-symmetric (if (or X Y) (or Y X)))
   (premise-1 (and (P) (or (Q) (R))))
   (x (or (and (P) (Q)) (and (P) (R))))))
