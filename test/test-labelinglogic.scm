
;; (define nocase?
;;   '(lambda (c)
;;      (and (char? c)
;;           (char-alphabetic? c)
;;           (not (char-upper-case? c))
;;           (not (char-lower-case? c)))))

;; (define numeric?
;;   `(lambda (c)
;;      (and (char? c)
;;           (char-numeric? c))))



;; (let ()
;;   (define model
;;     `((any (or alphanum upcase))
;;       (alphanum alphabetic)
;;       (alphabetic (or upcase (or upcase upcase)))
;;       (upcase (r7rs char-upper-case?))))

;;   (labelinglogic:model:check model))






;; (let ()
;;   (define model
;;     `((any (or alphanum upcase))
;;       (alphanum alphabetic)
;;       (alphabetic (or any (or upcase upcase)))
;;       (upcase (r7rs char-upper-case?))))

;;   (assert-throw
;;    'model-type-error
;;    (labelinglogic:model:check model)))







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
;;       (t_3  (= #\3))))

;;   (assert=

;;    `((t_an (or uid_1 uid_2 uid_3))
;;      (t_3 (= #\3))
;;      (uid_4 (r7rs char-numeric?))
;;      (uid_1 (r7rs char-upper-case?))
;;      (uid_2 (r7rs char-lower-case?))
;;      (uid_3 (or uid_4 t_3)))

;;    ;; `((t_an (or uid_1 t_3))
;;    ;;   (t_3 (= #\3))
;;    ;;   (uid_1
;;    ;;    (r7rs (lambda (c) (or
;;    ;;                       (or (char-upper-case? c)
;;    ;;                           (char-lower-case? c))
;;    ;;                       (char-numeric? c))))))

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





;; (let ()
;;   (define model
;;     `((numeric (r7rs ,numeric?))))

;;   ;; ( (Σ - "\"" - "\\") + ("\\" . Σ) )
;;   (define bindings
;;     `((t_q (and numeric (not (= #\0)) (not (= #\1))))))

;;   (assert=

;;    `((t_q (and uid_1 uid_2 uid_3))
;;      (uid_4 (r7rs (lambda (c)
;;                     (and (char? c)
;;                          (char-numeric? c)))))
;;      (uid_3 (= #\1))
;;      (uid_1 (or uid_4 uid_3))
;;      (uid_2 (= #\0)))

;;    ;; `((t_q (and uid_1 uid_2 uid_3))
;;    ;;   (uid_1 (r7rs (lambda (c)
;;    ;;                  (and (char? c)
;;    ;;                       (char-numeric? c)))))
;;    ;;   (uid_2 (= #\0))
;;    ;;   (uid_3 (= #\1)))

;;    (labelinglogic:model:alpha-rename
;;     '() (labelinglogic:init
;;          model bindings))))



;;;;;;;;;;;
;; TEST
;;;;;;;;;;;

(dprintln "hello")

(define (to-dnf expr-0)
  (define expr
    (labelinglogic:expression:desugar
     (labelinglogic:expression:move-nots-down expr-0)))

  (define (make type args)
    (labelinglogic:expression:make type args))

  (let loop ((expr expr))
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ;; If it's a literal (a variable or its negation), it's already in DNF
     ((or (boolean? expr) (variable? expr)) expr)

     ;; Should be already moved down
     ((not? expr) expr)

     ((or? expr)
      (make type (map loop args)))

     ((and? expr)
      (if (null? args) expr
          (let ()
            (define args* (map loop args))
            (define c (car args*))
            (define rest (cdr args*))
            (if (null? rest) expr
                (let ()
                  (define next (car rest))
                  (define next-type (labelinglogic:expression:type next))
                  (define next-args (labelinglogic:expression:args next))
                  (define c-type (labelinglogic:expression:type c))
                  (cond
                   ((equal? next-type 'or)
                    (loop
                     (make 'or
                       (map
                        (lambda (x) (make 'and (list c x)))
                        next-args))))
                   ((equal? c-type 'or)
                    (loop (make type (list next c))))
                   (else
                    (make 'and args*))))))))

     (else
      (error "Unrecognized expression" expr)))))

(define (and? expr)
  (and (pair? expr) (eq? (car expr) 'and)))

(define (or? expr)
  (and (pair? expr) (eq? (car expr) 'or)))

(define (not? expr)
  (and (pair? expr) (eq? (car expr) 'not)))

(define (variable? expr)
  (and (symbol? expr) (not (member expr '(and or not)))))

(assert=
 'kek
 (labelinglogic:expression:sugarify
  (to-dnf '(and x (not y) (or x y)))))
