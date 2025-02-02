
;;
;; Define test-case syntax.
;;

(define callback-alist/p
  (make-parameter '()))

(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* input* expected*)
     (let ()
       (define grammar grammar*)
       (define input input*)
       (define expected expected*)
       (define callback-alist (callback-alist/p))
       (define error-procedure
         (lambda _
           (unless (parselynn:ll-reject-action? expected)
             (raisu 'error-called))))

       (define table
         (parselynn:ll-compute-parsing-table grammar))

       (define (make-token category)
         (define source 'no-source)
         (define value category)
         (parselynn:token:make category source value))

       (define input-iterator
         (list->iterator (map make-token input)))

       (define result
         ((parselynn:ll-interpret table callback-alist)
          input-iterator error-procedure))

       (define to-compare
         (if (equal? #f result)
             (parselynn:ll-reject-action:make)
             result))

       (unless (equal? to-compare expected)
         (debug "\n\n\n----------------------------------\nactual:\n~s\n\n" result))

       (assert= to-compare expected)))))


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
    (parselynn:ll-reject-action:make))

  (test-case grammar input expected))


(let ()
  ;;
  ;; Simple arithmetic expression grammar.
  ;;
  ;;   Grammar:
  ;;
  ;; E -> T
  ;; E -> < E >
  ;; E -> + T E
  ;; E -> * T E
  ;; T -> x | y | z
  ;;

  (define grammar
    `((E (T) (< E >) (+ T E) (* T E))
      (T (x) (y) (z))))

  (define input
    `(+ x y))

  (define expected
    `(E + (T x) (E (T y))))

  (test-case grammar input expected))
