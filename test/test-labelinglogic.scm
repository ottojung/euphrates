
(define nocase?
  '(lambda (c)
     (and (char? c)
          (char-alphabetic? c)
          (not (char-upper-case? c))
          (not (char-lower-case? c)))))

(define numeric?
  `(lambda (c)
     (and (char? c)
          (char-numeric? c))))



(let ()
  (define model
    `((any (or alphanum upcase))
      (alphanum alphabetic)
      (alphabetic (or upcase (or upcase upcase)))
      (upcase (r7rs char-upper-case?))))

  (labelinglogic:model:check model))






(let ()
  (define model
    `((any (or alphanum upcase))
      (alphanum alphabetic)
      (alphabetic (or any (or upcase upcase)))
      (upcase (r7rs char-upper-case?))))

  (assert-throw
   'model-type-error
   (labelinglogic:model:check model)))







(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase lowercase))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an alphanum)
      (t_3  (= #\3))))

  (assert=

   ;; `((t_an (or (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (r7rs char-numeric?)))
   ;;   (t_3 (= #\3)))

   '((t_an (or (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (= #\3)
               (and (r7rs char-numeric?)
                    (not (= #\3)))))
     (t_3 (= #\3)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))



;; (let ()
;;   (define model
;;     `((any (or alphanum whitespace))
;;       (alphanum (or alphabetic numeric))
;;       (alphabetic (or upcase lowercase))
;;       (upcase (r7rs char-upper-case?))
;;       (lowercase (r7rs char-lower-case?))
;;       (numeric (r7rs char-numeric?))
;;       (whitespace (r7rs char-whitespace?))))

;;   (define bindings
;;     `((t_a (and alphanum (not (= #\5))))
;;       (t_b (and (not (= #\5)) alphanum))))

;;   (assert=

;;    `((t_a (or (and (r7rs char-upper-case?))
;;               (and (r7rs char-lower-case?))
;;               (and (r7rs char-numeric?)
;;                    (not (= #\5)))))
;;      (t_b (or (and (r7rs char-upper-case?))
;;               (and (r7rs char-lower-case?))
;;               (and (not (= #\5))
;;                    (r7rs char-numeric?)))))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))


(exit 0) ;; DEBUG


(let ()
  (define model
    `((any (or alphanum whitespace))
      (alphanum (or alphabetic numeric))
      (alphabetic (or upcase lowercase))
      (upcase (r7rs char-upper-case?))
      (lowercase (r7rs char-lower-case?))
      (numeric (r7rs char-numeric?))
      (whitespace (r7rs char-whitespace?))))

  (define bindings
    `((t_an (and alphanum (not (= #\5))))
      (t_bn (and alphanum (not (= #\7))))
      (t_cn (and (not (= #\5)) alphanum))
      (t_dn (and alphanum (not (= #\7)) (not (= #\8))))
      (t_en (and alphanum (not (= #\7)) (not (= #\.))))
      (t_fn (or t_an t_bn t_3))
      (t_3  (= #\3))))

  (assert=

   ;; `((t_an (or (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\5)))))
   ;;   (t_bn (or (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7)))))
   ;;   (t_cn (or (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (not (= #\5))
   ;;                  (r7rs char-numeric?))))
   ;;   (t_dn (or (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7))
   ;;                  (not (= #\8)))))
   ;;   (t_en (or (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7)))))
   ;;   (t_fn (or (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\5)))
   ;;             (and (r7rs char-upper-case?))
   ;;             (and (r7rs char-lower-case?))
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7)))
   ;;             (= #\3)))
   ;;   (t_3 (= #\3)))

   ;; '((t_an (or (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\5)))))
   ;;   (t_bn (or (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7)))))
   ;;   (t_cn (or (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (and (not (= #\5))
   ;;                  (r7rs char-numeric?))))
   ;;   (t_dn (or (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7))
   ;;                  (not (= #\8)))))
   ;;   (t_en (or (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7)))))
   ;;   (t_fn (or (and (r7rs char-numeric?)
   ;;                  (not (= #\5)))
   ;;             (r7rs char-upper-case?)
   ;;             (r7rs char-lower-case?)
   ;;             (and (r7rs char-numeric?)
   ;;                  (not (= #\7)))))
   ;;   (t_3 (= #\3)))

   '((t_an (or (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (and (r7rs char-numeric?)
                    (not (= #\5))
                    (not (= #\7))
                    (not (= #\8)))
               (= #\8)
               (= #\7)))
     (t_bn (or (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (and (r7rs char-numeric?)
                    (not (= #\5))
                    (not (= #\7))
                    (not (= #\8)))
               (= #\8)
               (= #\5)))
     (t_cn (or (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (and (r7rs char-numeric?)
                    (not (= #\5))
                    (not (= #\7))
                    (not (= #\8)))
               (= #\8)
               (= #\7)))
     (t_dn (or (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (and (r7rs char-numeric?)
                    (not (= #\5))
                    (not (= #\7))
                    (not (= #\8)))
               (= #\5)))
     (t_en (or (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (and (r7rs char-numeric?)
                    (not (= #\5))
                    (not (= #\7))
                    (not (= #\8)))
               (= #\8)
               (= #\5)))
     (t_fn (or (and (r7rs char-numeric?)
                    (not (= #\5))
                    (not (= #\7))
                    (not (= #\8)))
               (= #\8)
               (= #\7)
               (r7rs char-upper-case?)
               (r7rs char-lower-case?)
               (= #\5)))
     (t_3 (= #\3)))

   (labelinglogic:model:alpha-rename
    '() (labelinglogic:init
         model bindings))))







;; (let ()
;;   (define model
;;     `((any (or alphanum whitespace))
;;       (alphanum (or alphabetic numeric))
;;       (alphabetic (or upcase lowercase))
;;       (upcase (r7rs char-upper-case?))
;;       (lowercase (r7rs char-lower-case?))
;;       (numeric (r7rs char-numeric?))
;;       (whitespace (r7rs char-whitespace?))))

;;   (define bindings
;;     `((t_an alphanum)
;;       (t_3  (= #\3))
;;       (t_4  (= #\4))))

;;   (assert=

;;    `((t_an (or uid_1 uid_2 uid_3))
;;      (t_3 (= #\3))
;;      (t_4 (= #\4))
;;      (uid_4 (r7rs char-numeric?))
;;      (uid_1 (r7rs char-upper-case?))
;;      (uid_2 (r7rs char-lower-case?))
;;      (uid_3 (or uid_4 t_3)))

;;    ;; `((t_an (or uid_1 t_3 t_4))
;;    ;;   (t_3 (= #\3))
;;    ;;   (t_4 (= #\4))
;;    ;;   (uid_1 (r7rs (lambda (c)
;;    ;;                  (or (or (char-upper-case? c)
;;    ;;                          (char-lower-case? c))
;;    ;;                      (char-numeric? c))))))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))






;; (let ()
;;   (define model
;;     `((whitespace (r7rs char-whitespace?))))

;;   (define bindings
;;     `((t_an whitespace)
;;       (t_4  (or (= #\3) (= #\4)))
;;       (t_3  (= #\3))))

;;   (assert=

;;    `((t_an (r7rs char-whitespace?))
;;      (t_4 (or t_3 uid_1))
;;      (t_3 (= #\3))
;;      (uid_1 (= #\4)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))







;; (let ()
;;   (define model
;;     `((whitespace (r7rs char-whitespace?))))

;;   (define bindings
;;     `((t_an whitespace)
;;       (t_4  (or (= #\3) (= #\4) (= #\3)))))

;;   (assert=

;;    `((t_an (r7rs char-whitespace?))
;;      (t_4 (or uid_1 uid_2))
;;      (uid_1 (= #\3))
;;      (uid_2 (= #\4)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))











;; (let ()
;;   (define model
;;     `((any (or alphanum whitespace))
;;       (alphanum (or alphabetic numeric))
;;       (alphabetic (or upcase lowercase))
;;       (upcase (r7rs char-upper-case?))
;;       (lowercase (r7rs char-lower-case?))
;;       (numeric (r7rs char-numeric?))
;;       (whitespace (r7rs char-whitespace?))))

;;   (define bindings
;;     `((t_an alphabetic)
;;       (t_3  (= #\3))))


;;   (assert=

;;    `((t_an (or uid_1 uid_2))
;;      (t_3 (= #\3))
;;      (uid_1 (r7rs char-upper-case?))
;;      (uid_2 (r7rs char-lower-case?)))

;;    ;; `((t_an (r7rs (lambda (c) (or (char-upper-case? c) (char-lower-case? c)))))
;;    ;;   (t_3 (= #\3)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))




;; (let ()
;;   (define model
;;     `((any (or alphanum whitespace))
;;       (alphanum (or alphabetic numeric))
;;       (alphabetic (or upcase (or lowercase nocase)))
;;       (upcase (r7rs char-upper-case?))
;;       (lowercase (r7rs char-lower-case?))
;;       (nocase (r7rs ,nocase?))
;;       (numeric (r7rs char-numeric?))
;;       (whitespace (r7rs char-whitespace?))))

;;   (define bindings
;;     '((t_0 (= #\0))
;;       (t_1 (= #\1))
;;       (t_2 (= #\2))
;;       (t_3 (= #\3))
;;       (t_4 (= #\4))
;;       (t_5 (= #\5))
;;       (t_6 (= #\6))
;;       (t_7 (= #\7))
;;       (t_8 (= #\8))
;;       (t_m (= #\m))
;;       ;; (c_x (= #\x3))
;;       (t_a alphabetic)
;;       (t_n numeric)
;;       (t_x alphanum)))

;;   (assert=

;;    `((t_0 (= #\0))
;;      (t_1 (= #\1))
;;      (t_2 (= #\2))
;;      (t_3 (= #\3))
;;      (t_4 (= #\4))
;;      (t_5 (= #\5))
;;      (t_6 (= #\6))
;;      (t_7 (= #\7))
;;      (t_8 (= #\8))
;;      (t_m (= #\m))
;;      (t_a (or uid_1 uid_2 uid_3))
;;      (t_n (r7rs char-numeric?))
;;      (t_x (or t_a t_n))
;;      (uid_4 (r7rs char-lower-case?))
;;      (uid_1 (r7rs char-upper-case?))
;;      (uid_2 (or uid_4 t_m))
;;      (uid_3 (r7rs (lambda (c)
;;                     (and (char? c)
;;                          (char-alphabetic? c)
;;                          (not (char-upper-case? c))
;;                          (not (char-lower-case? c)))))))

;;    ;; `((t_0 (= #\0))
;;    ;;   (t_1 (= #\1))
;;    ;;   (t_2 (= #\2))
;;    ;;   (t_3 (= #\3))
;;    ;;   (t_4 (= #\4))
;;    ;;   (t_5 (= #\5))
;;    ;;   (t_6 (= #\6))
;;    ;;   (t_7 (= #\7))
;;    ;;   (t_8 (= #\8))
;;    ;;   (t_m (= #\m))
;;    ;;   (t_a (or uid_1 t_m))
;;    ;;   (t_n (or t_0 t_1 t_2 t_3 t_4 t_5 t_6 t_7 t_8 uid_2))
;;    ;;   (t_x (or t_a t_n))
;;    ;;   (uid_1 (r7rs (lambda (c)
;;    ;;                  (or (or (char-upper-case? c)
;;    ;;                          (char-lower-case? c))
;;    ;;                      (and (char? c)
;;    ;;                           (char-alphabetic? c)
;;    ;;                           (not (char-upper-case? c))
;;    ;;                           (not (char-lower-case? c)))))))
;;    ;;   (uid_2 (r7rs char-numeric?)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings)))

;;   )






;; (let ()
;;   (define model
;;     `((none (r7rs (lambda _ #f)))))

;;   (define bindings
;;     `((t_an none)
;;       (t_4  (or (= 0) (= 1)))))

;;   (assert=

;;    `((t_an (r7rs (lambda _ #f)))
;;      (t_4 (or uid_1 uid_2))
;;      (uid_1 (= 0))
;;      (uid_2 (= 1)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))



;; (let ()
;;   (define model `())

;;   (define bindings
;;     `((t_4  (or (= 0) (= 1)))))

;;   (assert=

;;    `((t_4 (or uid_1 uid_2))
;;      (uid_1 (= 0))
;;      (uid_2 (= 1)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))







;; (let ()
;;   (define model
;;     `((numeric (r7rs ,numeric?))))

;;   (define bindings
;;     `((t_n numeric)
;;       (t_4  (tuple (= #\a) (= #\b) (= #\c)))))

;;   (assert=

;;    `((t_n (r7rs ,numeric?))
;;      (t_4 (tuple uid_1 uid_2 uid_3))
;;      (uid_1 (= #\a))
;;      (uid_2 (= #\b))
;;      (uid_3 (= #\c)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))




;; (let ()
;;   (define model
;;     `((numeric (r7rs ,numeric?))))

;;   (define bindings
;;     `((t_n numeric)
;;       (t_4  (tuple (= #\3) (= #\4) (= #\5)))))

;;   (assert=

;;    `((t_n (or uid_1 uid_2))
;;      (t_4 (tuple uid_2 uid_3 uid_4))
;;      (uid_1 (r7rs (lambda (c)
;;                     (and (char? c)
;;                          (char-numeric? c)))))
;;      (uid_2 (= #\3))
;;      (uid_3 (= #\4))
;;      (uid_4 (= #\5)))

;;    ;; `((t_n (r7rs (lambda (c)
;;    ;;                (and (char? c)
;;    ;;                     (char-numeric? c)))))
;;    ;;   (t_4 (tuple uid_1 uid_2 uid_3))
;;    ;;   (uid_1 (= #\3))
;;    ;;   (uid_2 (= #\4))
;;    ;;   (uid_3 (= #\5)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))




;; (let ()
;;   (define model
;;     `((numeric (r7rs ,numeric?))))

;;   (define bindings
;;     `((t_n numeric)
;;       (t_4  (tuple (= #\3) (= #\4) (= #\3)))))

;;   (assert=

;;    `((t_n (or uid_1 uid_2))
;;      (t_4 (tuple uid_2 uid_3 uid_2))
;;      (uid_1 (r7rs (lambda (c)
;;                     (and (char? c)
;;                          (char-numeric? c)))))
;;      (uid_2 (= #\3))
;;      (uid_3 (= #\4)))

;;    ;; `((t_n (r7rs (lambda (c)
;;    ;;                (and (char? c)
;;    ;;                     (char-numeric? c)))))
;;    ;;   (t_4 (tuple uid_1 uid_2 uid_1))
;;    ;;   (uid_1 (= #\3))
;;    ;;   (uid_2 (= #\4)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))





;; ;; (let ()
;; ;;   (define model
;; ;;     `((numeric (r7rs ,numeric?))))

;; ;;   ;; ( (Σ - "\"" - "\\") + ("\\" . Σ) )
;; ;;   (define bindings
;; ;;     `((t_q (and numeric (not (= #\0)) (not (= #\1))))))

;; ;;   (assert=

;; ;;    `((t_q (and uid_1 uid_2 uid_3))
;; ;;      (uid_4 (r7rs (lambda (c)
;; ;;                     (and (char? c)
;; ;;                          (char-numeric? c)))))
;; ;;      (uid_3 (= #\1))
;; ;;      (uid_1 (or uid_4 uid_3))
;; ;;      (uid_2 (= #\0)))

;; ;;    ;; `((t_q (and uid_1 uid_2 uid_3))
;; ;;    ;;   (uid_1 (r7rs (lambda (c)
;; ;;    ;;                  (and (char? c)
;; ;;    ;;                       (char-numeric? c)))))
;; ;;    ;;   (uid_2 (= #\0))
;; ;;    ;;   (uid_3 (= #\1)))

;; ;;    (labelinglogic:model:alpha-rename
;; ;;     '() (labelinglogic:init
;; ;;          model bindings))))


