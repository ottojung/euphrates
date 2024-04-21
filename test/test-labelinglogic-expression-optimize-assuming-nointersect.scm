
;; Case with variable.
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(constant 3)))

(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (or (constant 2) (constant 3) (constant 4))
        (or (constant 5) (constant 6) (constant 7)))))

(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (or (constant 2) (constant 3) (constant 4))
        (or (constant 5) (constant 2) (constant 7)))))

(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (or (constant 2) (constant 3) (constant 4))
        (or (constant 5) (r7rs odd?) (constant 7)))))

(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (or (constant 2) (constant 3) (constant 4))
        (or (constant 5) (and (r7rs odd?) (not (constant 9))) (constant 7)))))

(assert=
 '(and (r7rs odd?) (not (constant 9)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(or (and (constant 3) (not (constant 5)))
       (and (r7rs odd?) (not (constant 9))))))

(assert=
 '(and (r7rs odd?) (not (constant 9)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(or (constant 3)
       (and (r7rs odd?) (not (constant 9))))))

(assert=
 '(and)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(or (constant 9) (not (constant 9)))))

(assert=
 '(and (r7rs odd?) (not (constant 3)) (not (constant 5)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(or (and (r7rs odd?) (not (constant 3)) (not (constant 5)))
       (and (r7rs odd?) (not (constant 3)) (not (constant 5)) (not (constant 7))))))

(assert=
 '(list (constant 1) (constant 1))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1) (constant 1)) (list (constant 1) (constant 1)))))


(assert=

 '(or (list (constant 1) (constant 2) (constant 1))
      (list (constant 1) (constant 4) (constant 1)))

 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (or (list (constant 1) (constant 2) (constant 1))
            (list (constant 1) (constant 3) (constant 1))
            (list (constant 1) (constant 4) (constant 1)))
        (not (list (constant 1) (constant 3) (constant 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Cases from labelinglogic:expression:optimize-dnf-clause/assuming-nointersect
;;

(assert=
 '(and)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and)))

(assert=
 '(constant 0)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 0) (constant 0))))

(assert=
 '(constant 0)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 0) (constant 0) (constant 0) (constant 0) (constant 0))))

(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 0) (constant 1))))

;; Optimizing non-intersecting negated lemma terms
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 1)) (constant 1))))

;; Optimizing non-intersecting r7rs terms
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (r7rs odd?))))

;; Different non-intersecting lists
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1) (constant 2)) (list (constant 3) (constant 4)))))

;; The same lists
(assert=
 '(list (constant 1) (constant 2))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1) (constant 2)) (list (constant 1) (constant 2)))))

;; Tuples with top expressions
(assert=
 '(list (constant 1) (constant 2))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1) (constant 2)) (list (constant 1) (constant 2)) (and))))

;; Tuples with bottom expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1) (constant 2)) (list (constant 1) (constant 2)) (or))))

;; Combining 'constant' and 'not =' [1]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (not (constant 3)))))

;; Combining 'constant' and 'not =' [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (not (constant 2)))))

;; Combining 'constant' and 'not =' [3]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (constant 2))))

;; Combining 'constant' and 'not =' [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 2)) (constant 2))))

;; Combining 'constant' and 'not =' [5]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (constant 2) (not (constant 3)) (not (constant 4)))))

;; Combining 'not =' and 'not =' [1]
(assert=
 '(and (not (constant 2)) (not (constant 3)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 2)) (not (constant 3)))))

;; Combining 'not =' and 'not =' [2]
(assert=
 '(not (constant 2))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 2)) (not (constant 2)))))

;; Combining 'r7rs' and 'not r7rs' [1]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (not (r7rs odd?)))))

;; Combining 'r7rs' and 'not r7rs' [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (not (r7rs even?)))))

;; Combining 'r7rs' and 'not r7rs' [3]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs odd?)) (r7rs even?))))

;; Combining 'r7rs' and 'not r7rs' [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs even?)) (r7rs even?))))

;; Combining 'r7rs' and 'not r7rs' [5]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs odd?)) (r7rs even?) (not (r7rs odd?)) (not (r7rs integer?)))))

;; Combining 'not r7rs' and 'not r7rs' [1]
;; NOTE: This does not simplify because detecting it is impossible.
;; NOTE: If we tried adding a "universe" notion, then we would not be able to use `(and)` anywhere,
;; NOTE: because that would make it the universe, and then this would not simplify again.
(assert=
 '(and (not (r7rs even?)) (not (r7rs odd?)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs even?)) (not (r7rs odd?)))))

;; Combining 'constant' and 'r7rs [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (constant 3))))

;; Combining 'constant' and 'r7rs [2]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (constant 2))))

;; Combining 'constant' and 'r7rs [3]
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (r7rs even?))))

;; Combining 'constant' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (r7rs even?) (constant 3))))

;; Combining 'constant' and 'r7rs [4]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 3) (r7rs even?) (constant 2))))

;; Combining 'constant' and 'r7rs [6]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (constant 2) (constant 4))))

;; Combining 'constant' and 'r7rs [7]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 4) (r7rs even?) (constant 2))))

;; Combining 'not =' and 'r7rs [1]
(assert=
 '(and (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (not (constant 2)))))

;; Combining 'not =' and 'r7rs [2]
(assert=
 '(and (not (constant 2)) (r7rs even?))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 2)) (r7rs even?))))

;; Combining 'not =' and 'r7rs [3]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [4]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (r7rs even?))))

;; Combining 'not =' and 'r7rs [5]
(assert=
 '(r7rs even?)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (r7rs even?) (not (constant 3)) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [6]
(assert=
 '(and (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (r7rs even?) (not (constant 2)))))

;; Combining 'not =' and 'r7rs [7]
(assert=
 '(and (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (not (constant 2)) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [8]
(assert=
 '(and (not (constant 4)) (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 4)) (r7rs even?) (not (constant 2)) (not (constant 3)))))

;; Combining 'not =' and 'r7rs [9]
(assert=
 '(and (not (constant 4)) (r7rs even?) (not (constant 2)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (not (constant 4)) (r7rs even?) (not (constant 2)))))

;; Combining 'constant' and '(not r7rs) [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (not (r7rs even?)))))

;; Combining 'constant' and '(not r7rs) [2]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs even?)) (constant 2))))

;; Combining 'constant' and '(not r7rs) [3]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 3) (not (r7rs even?)))))

;; Combining '(not =) and '(not r7rs) [1]
(assert=
 '(not (r7rs even?))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs even?)) (not (constant 2)))))

;; Combining '(not =) and '(not r7rs) [2]
(assert=
 '(and (not (r7rs even?)) (not (constant 3)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs even?)) (not (constant 3)))))

;; Checking negation of 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs odd?) (not (r7rs odd?)))))

;; Optimizing lists with different expressions [1]
(assert=
 '(constant 1)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1)) (list (r7rs odd?)))))

;; ;; Optimizing lists with different expressions [2]
;; (assert=
;;  '(and (list (constant 2)) (list (r7rs odd?)))
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 2)) (list (r7rs odd?)))))

;; ;; Optimizing lists with the same expressions
;; (assert=
;;  '(and (list (constant 1)))
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1)) (list (constant 1)))))

;; TODO
;; ;; Mixing 'list and 'not in a single expression
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1)) (not (list (constant 1))))))

;; Combining 'constant and 'r7rs with opposite values
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 1) (r7rs even?))))

;; More complex case with 'constant and 'r7rs
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (constant 2) (constant 2) (r7rs even?))))

;; More complex case with 'constant and 'r7rs
(assert=
 '(constant 2)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (constant 2) (constant 2) (r7rs even?) (constant 2) (constant 2))))

;; TODO
;; ;; Complex case with 'list and 'not
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1) (r7rs odd?)) (not (list (constant 1) (r7rs odd?))))))

;; Case with 'list and 'r7rs
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1)) (r7rs even?))))

;; Case with 'list and 'not with multiple types
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list (constant 1) (r7rs odd?)) (not (constant 1)) (not (r7rs odd?)))))

;; Testing with null values
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 0) (not (constant 0)))))

;; ;; Testing single list optimization
;; (assert=
;;  '(and (list (constant 2)))
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 2)) (list (constant 2)))))

;; Testing with multiple 'r7rs expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (r7rs odd?) (r7rs zero?))))

;; Testing with negated and non-negated 'r7rs expressions
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs even?) (not (r7rs even?)))))

;; Testing with opposite 'r7rs expression
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs positive?) (r7rs negative?))))

;; Test nointersect assumption on r7rs.
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (r7rs positive?) (r7rs integer?))))

;; Testing mixture of 'constant and 'r7rs expression with a common numeric value.
(define (test-1923123 expr)
  (define result
    (labelinglogic:expression:optimize/assuming-nointersect
     expr))

  (or (equal? result '(constant 2))
      (equal? result '(or))))

(assert (test-1923123 '(and (constant 2) (r7rs positive?) (r7rs integer?))))

;; Case with 'constant and 'list
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (list (constant 1)))))

;; Case with 'constant and complex 'list
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (list (r7rs even?) (constant 3)))))

;; Case with 'not and 'list
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 2)) (list (constant 2)))))

;; Case with 'not and complex 'list
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (r7rs even?)) (list (r7rs even?) (constant 3)))))

;; Case with 'constant and negated 'list
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 2) (not (list (constant 2))))))

;; ;; Case with 'not and negated 'list
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (not (constant 2)) (not (list (constant 2))))))

;; ;; Case with negated 'list and 'r7rs
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (not (list (constant 1))) (r7rs odd?))))

;; ;; Case with 'list, 'not, 'constant and 'r7rs values
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1)) (not (list (constant 1))) (r7rs odd?) (constant 2))))

;; ;; Case with 'list containing other 'list
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1) (list (r7rs odd?))) (not (list (constant 1))))))

;; ;; Case with complex mixture of types
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (r7rs odd?) (not (constant 1)) (not (r7rs odd?)) (list (constant 2) (r7rs even?)))))

;; ;; Case with identical 'list values
;; (assert=
;;  '(and (list (constant 1) (r7rs odd?)))
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1) (r7rs odd?)) (list (constant 1) (r7rs odd?)))))

;; ;; Case with non-identical 'list values
;; (assert=
;;  '(and (list (constant 1) (r7rs odd?)) (list (constant 2) (r7rs even?)))
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (constant 1) (r7rs odd?)) (list (constant 2) (r7rs even?)))))

;; ;; Case with 'constant, 'list and 'r7rs
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (constant 2) (r7rs even?) (list (constant 2) (r7rs even?)))))

;; ;; More complex case
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (r7rs positive?) (not (constant 2)) (list (constant 2) (r7rs odd?)))))

;; ;; Complex case with 'list, 'not and 'r7rs
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (r7rs even?)) (constant 2) (not (r7rs odd?)))))

;; ;; Complex case with complex 'list
;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect
;;   '(and (list (r7rs even?) (constant 2)) (r7rs positive?))))

;; Case with top. [1]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (and) (constant 3))))

;; Case with top. [2]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 3) (and))))

;; Case with top. [3]
(assert=
 '(constant 3)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (constant 3) (and) (constant 3))))

;; Case with top. [4]
(assert=
 '(and (not (constant 3)) (not (constant 5)))
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not (constant 3)) (and) (not (constant 5)))))

;; Case with top. [5]
(assert=
 '(and)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (and))))

;; Case with top. [5]
(assert=
 '(and)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (and) (and) (and))))

;; Case with bottom. [1]
(assert=
 '(or)
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (and) (or) (and) (and))))

(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and a b)))

;; Case with '((and))'
(assert-throw
 'unknown-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '((and))))

;; Case with numbers
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and 1 2 3)))

;; Case with top number
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect 812312))

;; Case with '((or))'
(assert-throw
 'unknown-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '((or))))

;; Case with '((list))'
(assert-throw
 'unknown-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '((list))))

;; Complex case with '((list))' and '((or))'
(assert-throw
 'unknown-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '((list) (or))))

;; Bad lists.
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (list 1 2))))

;; Bad nots.
(assert-throw
 'bad-sub-expr-type
 (labelinglogic:expression:optimize/assuming-nointersect
  '(and (not 1))))
