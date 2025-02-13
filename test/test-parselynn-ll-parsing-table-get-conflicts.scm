
;;
;; Define test-case syntax.
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* expected*)
     (let ()
       (define grammar grammar*)
       (define expected expected*)

       (define table
         (parselynn:ll-compute-parsing-table grammar))

       (define result/raw
         (parselynn:ll-parsing-table:get-conflicts table))

       (define (action->string action)
         (with-output-stringified
          (parselynn:ll-action:print action)))

       (define result
         (map (lambda (p)
                (define-pair (state conflicts) p)
                (cons state
                      (map
                       (lambda (x)
                         (define-pair (key actions) x)
                         (cons key (map action->string actions)))
                       conflicts)))
              result/raw))

       (unless (equal? result expected)
         (debug "\nexpected:\n~s\n\n" expected)
         (debug "\nactual:\n~s\n\n" result))

       (assert= result expected)))))


;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;



(let ()
  ;;
  ;; Simple grammar with single production.
  ;;
  ;;   Grammar:
  ;;
  ;; S -> a
  ;;

  (define grammar
    '((S (a))))

  (define expected
    '())

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple LL conflicting grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; S → num a | num b
  ;;
  ;;   Note:
  ;;
  ;; This grammar simply needs left factoring.
  ;;

  (define grammar
    '((S (num a) (num b))))

  (define expected
    `((S (num "S← num b" "S← num a"))))

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple LL conflicting grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; S → num a b c | num d e f
  ;;
  ;;   Note:
  ;;
  ;; This grammar simply needs left factoring.
  ;;

  (define grammar
    '((S (num a b c) (num d e f))))

  (define expected
    `((S (num "S← num d e f" "S← num a b c"))))

  (test-case grammar expected))


(let ()
  ;;
  ;; Simple LL non-conflicting grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; S → num S^
  ;; S^ → a b c | d e f
  ;;
  ;;   Note:
  ;;
  ;; This is the left-factored version of the previous grammar.
  ;;

  (define grammar
    '((S (num S^))
      (S^ (a b c) (d e f))))

  (define expected
    `())

  (test-case grammar expected))


(let ()
  ;;
  ;; Nonobvious conflicting grammar [1].
  ;;
  ;;   Grammar:
  ;;
  ;; S → L space split space R.
  ;; L → num | num space L.
  ;; R → num | num space R.
  ;;
  ;;   Notes:
  ;;
  ;; Taken from <https://codeberg.org/otto/euphrates/issues/46>.
  ;; Check here <https://smlweb.cpsc.ucalgary.ca/lr1.php?grammar=S+-%3E+L+space+split+space+R.%0AL+-%3E+num%0A+++%7C+num+space+L.%0AR+-%3E+num%0A+++%7C+num+space+R.%0A&substs=>.
  ;;

  (define grammar
    '((S (L space split space R))
      (L (num) (num space L))
      (R (num) (num space R))))

  (define expected
    `((L (num "L← num space L" "L← num"))
      (R (num "R← num space R" "R← num"))))

  (test-case grammar expected))
