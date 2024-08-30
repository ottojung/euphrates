
;;
;; Define test-case syntax.
;;


(define-syntax test-case
  (syntax-rules ()
    ((_ grammar* expected-text*)
     (let ()
       (define grammar grammar*)
       (define expected-text (string-strip expected-text*))

       (define result
         (parselynn:lr-compute-parsing-table grammar))

       (define text
         (string-strip
          (with-output-stringified
           (parselynn:lr-parsing-table:print
            result))))

       (unless (equal? text expected-text)
         (debug "\ncorrect:\n~a\n\n" text))

       (assert= text expected-text)))))


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

  (define expected-table
    "
+ ------------ +
!   !   $ !  a !
+ ------------ +
! 0 !     ! s1 !
+ ------------ +
! 1 ! ACC !    !
+ ------------ +
")

  (test-case grammar expected-table))


(let ()
  ;;
  ;; Youtube grammar. (https://invidious.reallyaweso.me/watch?v=sh_X56otRdU)
  ;;
  ;;   Grammar:
  ;;
  ;; S -> X X
  ;; X -> a X
  ;; X -> b
  ;;
  ;;   Notes:
  ;;
  ;; Compared to the reference graph:
  ;; - Our items have single symbols as lookaheads
  ;;   whereas the reference uses sets of symbols.
  ;;   Ex. we have both ", a" and ", b" instead of ", a/b".
  ;; - We have a different state 0.
  ;;   This is because we do not create an additional S' nonterminal.
  ;; - Correspondence between states is the following:
  ;;
  ;;       / Reference state # / Our state # /
  ;;       / ----------------- / ----------- /
  ;;       /         0         /      0      /
  ;;       /         1         /      -      /
  ;;       /         2         /      1      /
  ;;       /         3         /      3      /
  ;;       /         4         /      2      /
  ;;       /         5         /      5      /
  ;;       /         6         /      6      /
  ;;       /         7         /      7      /
  ;;       /         8         /      8      /
  ;;       /         9         /      4      /
  ;;       / ----------------- / ----------- /
  ;;
  ;;

  (define grammar
    '((S (X X))
      (X (a X)
         (b))))

  (define expected-table
    "
+ -------------------------------- +
!   !      $ !      a !      b ! X !
+ -------------------------------- +
! 0 !        !     s2 !     s3 ! 1 !
+ -------------------------------- +
! 1 !        !     s6 !     s7 ! 5 !
+ -------------------------------- +
! 2 !        !     s2 !     s3 ! 4 !
+ -------------------------------- +
! 3 !        !   X← b !   X← b !   !
+ -------------------------------- +
! 4 !        ! X← a X ! X← a X !   !
+ -------------------------------- +
! 5 !    ACC !        !        !   !
+ -------------------------------- +
! 6 !        !     s6 !     s7 ! 8 !
+ -------------------------------- +
! 7 !   X← b !        !        !   !
+ -------------------------------- +
! 8 ! X← a X !        !        !   !
+ -------------------------------- +
")

  (test-case grammar expected-table))
