
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
         (parselynn:lr-compute-parsing-table grammar))

       (define result/raw
         (parselynn:lr-parsing-table:get-conflicts table))

       (define (action->string action)
         (with-output-stringified
          (parselynn:lr-action:print action)))

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
    `((2 (space "s3" "L← num") (space "s3" "L← num"))))

  (test-case grammar expected))


(let ()
  ;;
  ;; Nonobvious conflicting grammar [2].
  ;;
  ;;   Grammar:
  ;;
  ;; (start    (left sep split sep right))
  ;; (left     (term) (term sep left))
  ;; (right    (term) (term sep left))
  ;; (sep      (SPACE))
  ;; (split    (/))
  ;; (term     (NUM))))
  ;;
  ;;   Notes:
  ;;
  ;; Taken from <https://codeberg.org/otto/euphrates/issues/46>.
  ;;

  (define grammar
    '((start    (left sep split sep right))
      (left     (term) (term sep left))
      (right    (term) (term sep left))
      (sep      (SPACE))
      (split    (/))
      (term     (NUM))))

  (define expected
    `((3 (SPACE "s4" "left← term") (SPACE "s4" "left← term"))))

  (test-case grammar expected))
