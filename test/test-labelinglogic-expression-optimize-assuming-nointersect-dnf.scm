
;; (assert=
;;  '(and)
;;  (labelinglogic:expression:optimize/assuming-nointersect-dnf
;;   '(and)))

;; (assert=
;;  '(and (= 0))
;;  (labelinglogic:expression:optimize/assuming-nointersect-dnf
;;   '(and (= 0) (= 0))))

(assert=
 '(and (= 0))
 (labelinglogic:expression:optimize/assuming-nointersect-dnf
  '(and (= 0) (= 0) (= 0) (= 0) (= 0))))

;; (assert=
;;  '(or)
;;  (labelinglogic:expression:optimize/assuming-nointersect-dnf
;;   '(and (= 0) (= 1))))
