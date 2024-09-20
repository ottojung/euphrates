
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





;; ;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;;  Test cases:
;; ;;




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
;;         (define v1 (map x p))
;;         (define v2 (map y v1))
;;         v2)))

;;  `((x (if (P) (Q)))
;;    (y (if (Q) (R)))
;;    (z (if (P) (R)))))


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
;;           (define v1 (map y p))
;;           (map v1 q)))))

;;  `((y (if (P) (if (Q) (R))))
;;    (z (if (Q) (if (P) (R))))))


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
;;           (beta ((beta (and-intro X) (P)) Y) (Q)))

;;         (let ((y (P))
;;               (w (Q)))
;;           (map (map and-intro-p-q y) w))))

;;     )

;;  `((and-elim (if (and X Y) X))
;;    (and-intro (if X (if Y (and X Y))))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (x (if (P) (if (Q) (and (P) (Q)))))))


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

;;     (define r1 (beta (and-elim X) (P)))
;;     (define r2 (beta (r1 Y) (Q)))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (map r2 m)))

;;     )

;;  `((and-elim (if (and X Y) X))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (r1 (if (and (P) Y) (P)))
;;    (r2 (if (and (P) (Q)) (P)))
;;    (x (if (and (P) (Q)) (P)))))


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

;;     (define s1 (beta (and-symmetric X) (P)))
;;     (define s2 (beta (s1 Y) (Q)))
;;     (define r1 (beta (and-elim X) (Q)))
;;     (define r2 (beta (r1 Y) (P)))

;;     (define x
;;       (let ((m (and (P) (Q))))
;;         (define swapped (map s2 m))
;;         (map r2 swapped)))

;;     )

;;  `((and-elim (if (and X Y) X))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (r1 (if (and (Q) Y) (Q)))
;;    (r2 (if (and (Q) (P)) (Q)))
;;    (s1 (if (and (P) Y) (and Y (P))))
;;    (s2 (if (and (P) (Q)) (and (Q) (P))))
;;    (x (if (and (P) (Q)) (Q)))))


;; (test-case
;;  ;;
;;  ;; Basic proof trivial.
;;  ;; Taken from https://www.logicmatters.net/resources/pdfs/ProofSystems.pdf, page 7.
;;  ;;

;;  '(define x (let ((p (P))) p))

;;  `((x (if (P) (P)))))


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
;;         (define r1 (beta (and-elim X) (P)))
;;         (define r2 (beta (r1 Y) (not (Q))))
;;         (define s1 (beta (and-symmetric X) (P)))
;;         (define s2 (beta (s1 Y) (not (Q))))
;;         (define sr1 (beta (and-elim X) (not (Q))))
;;         (define sr2 (beta (sr1 Y) (P)))
;;         (define Abs-q (beta (Abs X) (Q)))
;;         (define RAA-target (beta (RAA X) (and (P) (not (Q)))))
;;         (define and-intro-q-notq (beta ((beta (and-intro X) (Q)) Y) (not (Q))))

;;         (define tofalse
;;           (let ((m (and (P) (not (Q)))))
;;             (define p (map r2 m))
;;             (define swapped (map s2 m))
;;             (define notq (map sr2 swapped))
;;             (define q (map premise-1 p))
;;             (define q-and-notq (map (map and-intro-q-notq q) notq))
;;             (define bot (map Abs-q q-and-notq))
;;             bot))

;;         (map RAA-target tofalse)))

;;     )

;;  `((Abs (if (and X (not X)) (false)))
;;    (DN (if (not (not X)) X))
;;    (RAA (if (if X (false)) (not X)))
;;    (and-elim (if (and X Y) X))
;;    (and-intro (if X (if Y (and X Y))))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (premise-1 (if (P) (Q)))
;;    (x (not (and (P) (not (Q)))))))


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
;;         (define r1 (beta (and-elim X) (P)))
;;         (define r2 (beta (r1 Y) (not (Q))))
;;         (define s1 (beta (and-symmetric X) (P)))
;;         (define s2 (beta (s1 Y) (not (Q))))
;;         (define sr1 (beta (and-elim X) (not (Q))))
;;         (define sr2 (beta (sr1 Y) (P)))
;;         (define Abs-q (beta (Abs X) (Q)))
;;         (define RAA-target (beta (RAA X) (and (P) (not (Q)))))
;;         (define and-intro-q-notq (beta ((beta (and-intro X) (Q)) Y) (not (Q))))

;;         (define tofalse
;;           (let ((m (and (P) (not (Q)))))
;;             (define p (map r2 m))
;;             (define swapped (map s2 m))
;;             (define notq (map sr2 swapped))
;;             (define q (map premise-1 p))
;;             (define q-and-notq (map (map and-intro-q-notq q) notq))
;;             (define bot (map Abs-q q-and-notq))
;;             bot))

;;         (map RAA-target tofalse)))

;;     )

;;  `((Abs (if (and X (not X)) (false)))
;;    (DN (if (not (not X)) X))
;;    (RAA (if (if X (false)) (not X)))
;;    (and-elim (if (and X Y) X))
;;    (and-intro (if X (if Y (and X Y))))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (premise-1 (if (P) (Q)))
;;    (x (not (and (P) (not (Q)))))))


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
;;         (define r1 (beta (and-elim X) (P)))
;;         (define r2 (beta (r1 Y) (not (Q))))
;;         (define s1 (beta (and-symmetric X) (P)))
;;         (define s2 (beta (s1 Y) (not (Q))))
;;         (define sr1 (beta (and-elim X) (not (Q))))
;;         (define sr2 (beta (sr1 Y) (P)))
;;         (define Abs-1 (beta (Abs X) (and (P) (not (Q)))))
;;         (define RAA-target (beta (RAA X) (not (Q))))
;;         (define DN-target (beta (DN X) (Q)))
;;         (define and-intro-p-notq (beta ((beta (and-intro X) (P)) Y) (not (Q))))
;;         (define and-intro-p-notq-premise-1 (beta ((beta (and-intro X) (and (P) (not (Q)))) Y) (not (and (P) (not (Q))))))

;;         (let ((p (P)))
;;           (define contr1
;;             (let ((notq (not (Q))))
;;               (define and-p-notq (map (map and-intro-p-notq p) notq))
;;               ;; (define contr1 (and and-p-notq premise-1))
;;               (define contr1 (map (map and-intro-p-notq-premise-1 and-p-notq) premise-1))
;;               (define abs1 (map Abs-1 contr1))
;;               abs1))

;;           (define nnq (map RAA-target contr1))
;;           (map DN-target nnq))))

;;     )

;;  `((Abs (if (and X (not X)) (false)))
;;    (DN (if (not (not X)) X))
;;    (EFQ (if (false) X))
;;    (RAA (if (if X (false)) (not X)))
;;    (and-elim (if (and X Y) X))
;;    (and-intro (if X (if Y (and X Y))))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (premise-1 (not (and (P) (not (Q)))))
;;    (x (if (P) (Q)))))


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
;;         (define and-intro-p-q (beta ((beta (and-intro X) (P)) Y) (Q)))
;;         (define and-intro-p-r (beta ((beta (and-intro X) (P)) Y) (R)))
;;         (define or-intro-p-q-p-r-1 (beta ((beta (or-intro-left X) (and (P) (Q))) Y) (and (P) (R))))
;;         (define or-intro-p-q-p-r-2 (beta ((beta (or-intro-right X) (and (P) (Q))) Y) (and (P) (R))))
;;         (define p (map (beta ((beta (and-elim-left X) (P)) Y) (or (Q) (R)))
;;                          premise-1))
;;         (define reversed (map (beta ((beta (and-symmetric X) (P)) Y) (or (Q) (R)))
;;                                 premise-1))

;;         (define or-elim-target
;;           (let ()
;;             (define a (beta (or-elim X) (Q)))
;;             (define b (beta (a Y) (R)))
;;             (define c (beta (b Z) (or (and (P) (Q)) (and (P) (R)))))
;;             c))

;;         (define or-q-r (map (beta ((beta (and-elim-left Y) (P)) X) (or (Q) (R)))
;;                               reversed))

;;         (define q-><p-&-q/p-&-r>
;;           (let ((q (Q)))
;;             (define p-and-q
;;               (map (map and-intro-p-q p) q))

;;             (map or-intro-p-q-p-r-1 p-and-q)))

;;         (define r-><p-&-q/p-&-r>
;;           (let ((r (R)))
;;             (define p-and-r
;;               (map (map and-intro-p-r p) r))

;;             (map or-intro-p-q-p-r-2 p-and-r)))

;;         (define or-elim-target-1
;;           (map or-elim-target or-q-r))

;;         (define or-elim-target-2
;;           (map or-elim-target-1 q-><p-&-q/p-&-r>))

;;         (define or-elim-target-3
;;           (map or-elim-target-2 r-><p-&-q/p-&-r>))

;;         or-elim-target-3))

;;     )

;;  `((Abs (if (and X (not X)) (false)))
;;    (DN (if (not (not X)) X))
;;    (EFQ (if (false) X))
;;    (RAA (if (if X (false)) (not X)))
;;    (and-elim-left (if (and X Y) X))
;;    (and-elim-right (if (and X Y) Y))
;;    (and-intro (if X (if Y (and X Y))))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (or-elim
;;     (if (or X Y) (if (if X Z) (if (if Y Z) Z))))
;;    (or-intro-left (if X (or X Y)))
;;    (or-intro-right (if Y (or X Y)))
;;    (or-symmetric (if (or X Y) (or Y X)))
;;    (premise-1 (and (P) (or (Q) (R))))
;;    (x (or (and (P) (Q)) (and (P) (R))))))


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
;;           (beta ((beta (and-elim-left X) (not P)) Y) (not Q)))

;;         (define and-elim-left-p-notp
;;           (beta ((beta (and-elim-left X) P) Y) (not P)))

;;         (define and-elim-right-p-notp
;;           (beta ((beta (and-elim-right X) P) Y) (not P)))

;;         (define and-intro-p-notp
;;           (beta ((beta (and-intro X) P) Y) (not P)))

;;         (define abs-p
;;           (beta (Abs X) P))

;;         (define raa1-rule (beta (RAA X) (and (not P) (not Q))))

;;         (define and-intro-notp-notq
;;           (when (beta ((beta (and-intro X) (not P)) Y) (not Q))
;;             (if (not P) (if (not Q) (and (not P) (not Q))))))

;;         (define and-intro-1
;;           (when (beta ((beta (and-intro X) (and (not P) (not Q))) Y)
;;                       (not (and (not P) (not Q))))
;;             (if (and (not P) (not Q))
;;                 (if (not (and (not P) (not Q)))
;;                     (and (and (not P) (not Q)) (not (and (not P) (not Q))))))))

;;         (define abs-1
;;           (when (beta (Abs X) (and (not P) (not Q)))
;;             (if (and (and (not P) (not Q)) (not (and (not P) (not Q)))) (false))))

;;         (define notq-raa
;;           (when (beta (RAA X) (not Q))
;;             (if (if (not Q) (false)) (not (not Q)))))

;;         (define DN-q
;;           (alpha (DN X) Q))

;;         (let ((p-and-notp (and P (not P))))

;;           (define p (map and-elim-left-p-notp p-and-notp))
;;           (define notp (map and-elim-right-p-notp p-and-notp))

;;           (define false1
;;             (let ((not-p-and-not-q (and (not P) (not Q))))
;;               (define and-p-notp (map (map and-intro-p-notp p) notp))
;;               (map abs-p and-p-notp)))

;;           (define raa1
;;             (when (map raa1-rule false1)
;;               (not (and (not P) (not Q)))))

;;           (define not<q>->false
;;             (let ((notq (not Q)))
;;               (define and-p-notp
;;                 (when (map (map and-intro-notp-notq notp) notq)
;;                   (and (not P) (not Q))))

;;               (define y
;;                 (when (map (map and-intro-1 and-p-notp) raa1)
;;                   (and (and (not P) (not Q)) (not (and (not P) (not Q))))))

;;               (define yabs
;;                 (when (map abs-1 y)
;;                   (false)))

;;               yabs))

;;           (when not<q>->false
;;             (if (not Q) (false)))

;;           (define not<not<q>>
;;             (when (map notq-raa not<q>->false)
;;               (not (not Q))))

;;           (map DN-q not<not<q>>))))

;;     )

;;  `((Abs (if (and X (not X)) (false)))
;;    (DN (if (not (not X)) X))
;;    (RAA (if (if X (false)) (not X)))
;;    (and-elim-left (if (and X Y) X))
;;    (and-elim-right (if (and X Y) Y))
;;    (and-intro (if X (if Y (and X Y))))
;;    (and-symmetric (if (and X Y) (and Y X)))
;;    (or-elim
;;     (if (or X Y) (if (if X Z) (if (if Y Z) Z))))
;;    (or-intro-left (if X (or X Y)))
;;    (or-intro-right (if Y (or X Y)))
;;    (or-symmetric (if (or X Y) (or Y X)))
;;    (x (if (and P (not P)) Q))))


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


;;  `((x (P))
;;    (y (and x (P)))
;;    (z (and x (P)))))


;; ;; (test-case
;; ;;  ;;
;; ;;  ;; Case for Universal Instantiation rule.
;; ;;  ;;

;; ;;  '(begin
;; ;;     (define x
;; ;;       (axiom (c1)))

;; ;;     (define y
;; ;;       (axiom (forall (m) (P (m)))))

;; ;;     (define beta-rule ;; This is like generalized ((X /\ ~X) -> Y)
;; ;;       (axiom (if (not X) (if B (map B (if X Y))))))

;; ;;     (define universal-instantiation
;; ;;       (axiom (if t (if (forall x B) (map B (if x t))))))

;; ;;     (define universal-generalization
;; ;;       (axiom (if c (if (if P Q) (map (forall c Q) (if P c))))))

;; ;;     (define existential-generalization
;; ;;       (axiom (if c (if B (if x (exists c (map B (if x c))))))))

;; ;;     (define existential-instantiation
;; ;;       (axiom (if (exists x B) (map B (if x B)))))

;; ;;       ;; (axiom (if k (if (forall m X) (if m k)))))



;; ;;     )


;; ;;  `((x (P))
;; ;;    (y (and x (P)))
;; ;;    (z (and x (P)))))


;; ;;;;;;;;;;;;;;;;;;
;; ;;
;; ;;  Using MAP here...
;; ;;

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
        (define v1 (map x p))
        (define v2 (map y v1))
        v2)))

 `((x (if (P) (Q)))
   (y (if (Q) (R)))
   (z (if (P) (R)))))


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
        (define or-intro-left
          (axiom (if X (or X Y))))

        (define excluded-middle
          (axiom (or X (not X))))

        (define and-intro-p-q
          (beta ((beta (and-intro X) (P)) Y) (Q)))

        (when and-intro-p-q
          (if (P) (if (Q) (and (P) (Q)))))

        (define EFQ ;; The "ex-falso-quodlibet" law.
          (axiom (if (false) X)))

        (define or-intro-left-p-q
          (beta ((beta (or-intro-left X) (P)) Y) (Q)))

        (when or-intro-left-p-q
          (if (P) (or (P) (Q))))

        (define impl
          (let ()

            (define xxx
              (let ((p (P)))
                (define false->p (let ((w (false))) p))
                (map false->p EFQ)))

            (when xxx
              (if (P) (if (P) X)))

            ;; (define impl1
            ;;   (let ((x->p (if X (P))))
            ;;     (define ret
            ;;       (map x->p or-intro-left))

            ;;     (when ret (if (P) (or (P) Y)))

            ;;     ret))

            (define impl1
              (let ((x X))
                (let ((p (P)))
                  (define x->p (let ((x X)) p))

                  (map x->p or-intro-left))))

            (when impl1
              (if X (if (P) (if (P) (or (P) Y)))))

            (define direct
              (let ((p (P)))
                (define x->p (let ((x X)) p))
                (map x->p or-intro-left)))

            (when direct
              (if (P) (if (P) (or (P) Y))))

            (define direct-rename
              (let ((w W))
                (define x->p (let ((x X)) w))
                (map x->p or-intro-left)))

            (when direct-rename
              (if W (if W (or W Y))))

            ;; (when impl1
            ;;   (if X (if (P) (if (P) (or (P) Y)))))


                ;;     (define ret
                ;;   (map x->p or-intro-left))

                ;; (when ret (if (P) (or (P) Y)))

                ;; ret))

            ;; (when impl1
            ;;   (if (if X (P))
            ;;       (if (P) (or (P) Y))))

            ;; (define impl1
            ;;   (axiom (if X (if (P) (if (P) (or (P) Y))))))

            ;; (define impl2
            ;;   (axiom (if (not X) (if (P) (if (P) (or (P) Y))))))

            ;; (define conclusion
            ;;   (axiom (if (P) (if (P) (or (P) Y)))))

            0))

        (let ((y (P))
              (w (Q)))
          (map (map and-intro-p-q y) w))))

    )

 `((and-elim (if (and X Y) X))
   (and-intro (if X (if Y (and X Y))))
   (and-symmetric (if (and X Y) (and Y X)))
   (x (if (P) (if (Q) (and (P) (Q)))))))
