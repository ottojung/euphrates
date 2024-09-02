
;;
;; Define test-case syntax.
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* input* expected*)
     (let ()
       (define grammar grammar*)
       (define input input*)
       (define expected expected*)

       (define table
         (parselynn:lr-compute-parsing-table grammar))

       (define input-iterator
         (list->iterator input))

       (define result
         (parselynn:lr-interpret table input-iterator))

       (unless (equal? result expected)
         (debug "\nactual:\n~s\n\n" result))

       (assert= result expected)))))


;;;;;;;;;;;;;;;;;
;;
;; Test cases:
;;


(let ()
  ;;
  ;; Empty grammar.
  ;;
  ;;   Grammar:
  ;;

  (define grammar
    '())

  (define input
    '(a b c d))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Empty grammar.
  ;;
  ;;   Grammar:
  ;;

  (define grammar
    '())

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '(a))

  (define expected
    '(a))

  (test-case grammar input expected))


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

  (define input
    '(b))

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


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

  (define input
    '())

  (define expected
    (parselynn:lr-reject-action:make))

  (test-case grammar input expected))


;; (let ()
;;   ;;
;;   ;; Simple grammar with two productions.
;;   ;;
;;   ;;   Grammar:
;;   ;;
;;   ;; S -> E
;;   ;; E -> a
;;   ;;

;;   (define grammar
;;     '((S (E))
;;       (E (a))))

;;   (define input
;;     '(a))

;;   (define expected
;;     0)
;;     ;; (parselynn:lr-reject-action:make))

;;   (test-case grammar input expected))
