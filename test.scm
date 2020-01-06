
;; USAGE:

(add-to-load-path "..")
;; OR

;; (use-modules [srfi srfi-98]) ;; get-environment-variable
;; (add-to-load-path
;;  (string-join
;;   (list
;;    (get-environment-variable "HOME")
;;    "lib")
;;   "/"))

;; OR
;; set GUILE_LOAD_PATH+=$HOME/lib

;; then:
(use-modules [my-guile-std common])
(use-modules [ice-9 threads])
(use-modules [ice-9 textual-ports])
(use-modules [[srfi srfi-18]
              #:select [make-mutex mutex-lock! mutex-unlock!]
              #:prefix srfi::])

(define k (letin
           [i 2]
           [c 3]
           (+ i c)))

(format #t "loop = ~a\n" (apploop [x] [5] (if (= 0 x) 1 (* x (loop (- x 1))))))

(format #t "k = ~a\n" k)

(+ 5 10)

(display "Hello, Guile!\n")

;; scoping test
(apploop [x] [20]
		 (format #t "up ~a\n" x)
		 (unless (> x 24)
		   (let [[z 10]]
			 (apploop [x] [3]
					  (format #t "dw ~a\n" x)
					  (if (= x 0)
						  x
						  (loop (1- x))))
			 (loop (1+ x)))))

(define x (format #t "z = ~a\n" (* 2/3 1/3)))

(format #t "x = ~a\n" x)

(define zzz 20)

(+ zzz zzz)

(format #t "fn = ~a\n" ((fn i (* 2 i)) 5))

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

(format #t "dom-default = ~a\n" (calc-default))

(format #t "dom parameterized = ~a\n"
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

(format #t "haha = ~a\n" (haha))
;; (format #t "kekloop = ~a\n" kekloop)
;; (format #t "hahahelo = ~a\n" hahahelo)

(format #t "haha<int>(5) = ~a\n" (haha 5)) ;; TODO: fix

(define zz (mdict 1 2 3 4))
(printf "call(3) = ~a\n" (zz 3))
(printf "set(3, 5) = ~a\n" (set! (zz) 5))
(define z2 (mass zz 3 99))
(printf "call(3) = ~a\n" (z2 3))
(printf "set(3, 5) = ~a\n" (set! (z2) 5))
(printf "has(3) = ~a\n" (mdict-has? z2 3))
(printf "has(52) = ~a\n" (mdict-has? z2 52))
(printf "keys(z2) = ~a\n" (mdict-keys z2))

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

(np-thread-start
 (lambda []
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

   (println "end")))

;; (define cur (current-thread))
;; (i-thread-yield cur)

(i-thread-start
 (lambda []
   (println "preemptive test")

   (define [kek]
     (println "in kek"))

   (define cycles 20)

   (define [lol]
     (apploop [n] [0]
              (if (> n cycles)
                  (println "lol ended")
                  (begin
                    (println "lol at ~a" n)
                    (usleep 100000)
                    (loop (1+ n))))))

   (define [zulul]
     (apploop [n] [0]
              (if (> n cycles)
                  (println "zulul ended")
                  (begin
                    (println "zulul at ~a" n)
                    (usleep 100000)
                    (loop (1+ n))))))

   (np-thread-fork kek)
   (np-thread-fork lol)
   (np-thread-fork zulul)

   (println "end")))

(i-thread-start
 (lambda []
   ;; (i-thread-yield-me)

   (println "critical test")

   (define [kek]
     (println "in kek"))

   (define cycles 20)

   (define [lol]
     (i-thread-critical!
      (apploop [n] [0]
               (if (> n cycles)
                   (println "lol ended")
                   (begin
                     (println "lol at ~a" n)
                     (usleep 100000)
                     (loop (1+ n)))))))

   (define [zulul]
     (i-thread-critical!
      (apploop [n] [0]
               (if (> n cycles)
                   (println "zulul ended")
                   (begin
                     (println "zulul at ~a" n)
                     (usleep 100000)
                     (loop (1+ n)))))))

   (np-thread-fork kek)
   (np-thread-fork lol)
   (np-thread-fork zulul)

   (println "end")))

(let [[p (run-process OPEN_BOTH "echo" "hello" "from" "echo")]]
  (display
   (get-string-all (pipe:process p))))

(let [[p (run-process OPEN_BOTH "sl")]]
  (port-redirect
   (pipe:process p)
   (current-output-port)))

