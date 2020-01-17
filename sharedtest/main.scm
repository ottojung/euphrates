
(define k (letin
           [i 2]
           [c 3]
           (+ i c)))

;; (define-rec-strs "rec1" "aa" "bb")
(define-rec rec1 aa bb)

(define rec (rec1 1 2))

(println "record? ~a" (record? rec))
(println "aa = ~a" (rec1-aa rec))
(set-rec1-aa! rec 10)
(println "aa = ~a" (rec1-aa rec))

(printf "loop = ~a\n" (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1))))))

(printf "k = ~a\n" k)

(+ 5 10)

(display "Hello, Guile!\n")

;; (println "tree:\n~a\n\n" (directory-tree "."))
(println "files:\n~a\n\n" (directory-files "."))
;; (println "files-rec:\n~a\n\n" (directory-files-rec "."))
;; (println "rec only names:\n~a\n\n" (map cadr (directory-files-rec ".")))

;; scoping test
(apploop [x] [20]
		 (printf "up ~a\n" x)
		 (unless (> x 24)
		   (let [[z 10]]
			 (apploop [x] [3]
					  (printf "dw ~a\n" x)
					  (if (= x 0)
						  x
						  (loop (1- x))))
			 (loop (1+ x)))))

(define x (printf "z = ~a\n" (* 2/3 1/3)))

(printf "x = ~a\n" x)

(define zzz 20)

(+ zzz zzz)

(printf "fn = ~a\n" ((fn i (* 2 i)) 5))

(letin-with-full dom-print
                 [a (+ 2 7)]
                 [b (* a 10)]
                 (* b b))

(define [calc-default]
  (dom (dom-default (fn x (= x 0)))
       [a (+ 2 7)]
       [b (* a 10)]
       [c (- b b)]
       (+ 100 c)))

(printf "dom-default = ~a\n" (calc-default))

(printf "dom parameterized = ~a\n"
        (letin-parameterize
         (fn f fname
             (fn xqt resultqt x cont
                 (1+ (f xqt resultqt x cont))))
         (calc-default)))

(gfunc/define haha)


;; (gfunc/instantiate-haha (list integer?) (lambda (i) (* i 2)))
(gfunc/instance haha [integer?]
                (fn i (* i 10)))

(gfunc/instantiate-haha (list) (lambda () 2))
;; (gfunc/instance haha []
;;                 (fn 2))

(printf "haha = ~a\n" (haha))
;; (printf "kekloop = ~a\n" kekloop)
;; (printf "hahahelo = ~a\n" hahahelo)

(printf "haha<int>(5) = ~a\n" (haha 5)) ;; TODO: fix

(println "~a" (list-fold 1 (range 1 5) *))
(println "~a" (list-fold 1 (range 1 5) (lambda [acc x] (* acc x))))
(println "~a" (lfold 1 (range 1 5) (* acc x)))

(println (simplify-posix-path "/hello/../there/./bro/"))
(println (append-posix-path "hello/there/" "bro"))
(println (append-posix-path "hello/there" "bro"))
(println (append-posix-path "hello/there" ".." "and/" "bro" "." "hello"))
(println (simplify-posix-path (append-posix-path "hello/there" ".." "and/" "bro" "." "hello")))
;; (println (append-posix-path "hello/there" "/bro"))

(define [hell2 x]
  (with-return
   (printf "hahaha\n")
   (printf "job = ~a\n" 2)
   (return 55)
   (+ 2 x)))

(printf "expect 55 : ~a\n" (hell2 50))


(with-bracket
 (lambda [return]
   (printf "locked\n")
   (return 5)
   (printf "should not happend\n"))
 (lambda []
   (printf "unlocked\n")))

;; (catch #t
;;   (lambda []

;;     (with-bracket
;;      (lambda [return]
;;        (printf "locked 'ex\n")
;;        (throw 'kek)
;;        (printf "should not happend\n"))
;;      (lambda []
;;        (printf "unlocked 'ex\n"))))

;;   (lambda args
;;     (printf "~a\n" args)))

(with-bracket
 (lambda [return]
   (printf "composite locked\n")

   ;; (return 2)

   (with-bracket
    (lambda [return2]
      (printf "composite locked 2\n")
      ;; (return 5)

      (with-bracket
       (lambda [return3]
         (printf "composite locked 3\n")
         (return 5)
         ;; (throw 'zzz 55)
         ;; (return2 7)
         ;; (return3 9)
         (printf "should not happend\n"))
       (lambda []
         (printf "composite unlocked 3\n")))

      ;; (return2 7)
      (printf "maybe should happend 2\n"))
    (lambda []
      (printf "composite unlocked 2\n")))

   (printf "maybe should happend\n"))
 (lambda []
   (printf "composite unlocked\n")))

(np-thread-run!
 (println "hello")

 (define [kek]
   (println "in kek"))

 (define cycles 3)

 (define [lol]
   (apploop [n] [0]
            (if (> n cycles)
                (println "lol ended")
                (begin
                  (println "lol at ~a" n)
                  (np-thread-yield)
                  (println "lol after ~a" n)
                  (loop (1+ n))))))

 (define [zulul]
   (apploop [n] [0]
            (if (> n cycles)
                (println "zulul ended")
                (begin
                  (println "zulul at ~a" n)
                  (np-thread-yield)
                  (println "zulul after ~a" n)
                  (loop (1+ n))))))

 (np-thread-fork kek)
 (np-thread-fork lol)
 (np-thread-fork zulul)

 (println "end"))


;;;;;;;;;;;;;;;;
;; STACK FLOW ;;
;;;;;;;;;;;;;;;;

(define/stack [ADD-TO-7]
  (PUSH 7)
  ADD)

(println
 "stack result = ~a"
 (st
  (PUSH 2)
  (PUSH 3)
  ADD
  (PUSH 5)
  MUL
  ADD-TO-7
  (lambda [x] (println "stack op1 result = ~a" x) x)
  NEGATE
  (PUSH 100)
  ADD))

(define stack-k #f)

(println
 "stack result = ~a"
 (st
  (PUSH 2)
  (PUSH 3)
  ADD
  PUSH/CC
  (lambda [k]
    (println "got k = ~a" k)
    (if (procedure? k)
        (begin
          (set! stack-k k)
          5)
        (begin
          (set! stack-k (lambda lst 77))
          77)))
  MUL
  (CALL
   (lambda [n]
     (println "MUL result = ~a" n)
     (println "AFTER CALL TO ~a" (stack-k (list n)))
     n))
  (PUSH "END")
  (PRINT)))

(st
 (PUSH "PROJ and MAP test")
 (PRINT)
 (PUSH (list 2 3))
 (PROJ car cadr)
 (MAP (STORE x) (STORE y))
 (lambda [x y] (println "x = ~a ; y = ~a" x y) x)
 (LOAD x)
 (lambda [x] (println "LOAD x = ~a" x) x)
 (LOAD y)
 (lambda [x] (println "LOAD y = ~a" x) x))

(st
 (PUSH "GOTO test")
 (PRINT)
 (PUSH (list 2 3))
 (PROJ car cadr)
 (MAP (STORE x) (STORE y))
 (lambda [x y] (println "x = ~a ; y = ~a" x y) x)
 PUSH/CC
 (STORE/DEFAULT cont1)
 (LOAD x)
 (PUSH 1)
 ADD
 (STORE x)
 (lambda [x] (println "LOAD x = ~a" x) x)
 (lambda [x]
   (if (< x 10)
       (GOTO (LOAD cont1))
       identity))
 EVAL
 (LOAD y)
 (lambda [x] (println "LOAD y = ~a" x) x))

