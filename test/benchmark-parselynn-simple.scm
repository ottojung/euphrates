
(define (iterate-results iter)
  (let loop () (when (iter) (loop))))


(define (run/generic parser input n-runs)
  (let loop ((i n-runs))
    (when (< 0 i)
      (let ()
        (define result
          (parselynn/simple:run/with-error-handler
           parser ignore input))

        (if (< 1 i)
            (loop (- i 1))
            (let ()
              (define arguments
                (parselynn/simple-struct:arguments parser))
              (define options
                (keylist->alist arguments))
              (define driver
                (assoc-or ':driver options (raisu 'impossible-8466123)))

              (with-benchmark/timestamp "parsed input")
              (cond
               ((equal? driver 'lr)
                (assert (pair? result))
                (assert= 'expr (car result)))
               ((equal? driver 'glr)
                (assert (procedure? result))
                (assert= #t (result 'get))
                (iterate-results result))
               (else
                (raisu 'unrecognized-driver driver)))))))))

(define (repeating-template driver load? seq-len n-runs)
  (define _8123 (assert= driver "lr"))
  (define _4632 (assert= load? #f))

  (define input
    (let ()
      (define count 0)
      (define constant-s (make-string seq-len))
      (define normal-s
        (string-map
         (lambda (c)
           (set! count (+ 1 count))
           (case (remainder count 2)
             ((1) #\5)
             ((0) #\+)))
         constant-s))
      normal-s))

  (with-benchmark/timestamp "constructed input")

  (define parser
    (parselynn/simple
     `(:grammar
       ( expr = expr add expr / term
         add = "+"
         term = NUM
         NUM = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

       :driver ,(string->symbol driver))))

  (with-benchmark/timestamp "constructed parser")
  (run/generic parser input n-runs))



;;;;;
;;;;;
;;;;;
;;;;;             ▄▄▄▄    ▄                    ▄
;;;;;            █▀   ▀ ▄▄█▄▄   ▄▄▄    ▄ ▄▄  ▄▄█▄▄
;;;;;            ▀█▄▄▄    █    ▀   █   █▀  ▀   █
;;;;;                ▀█   █    ▄▀▀▀█   █       █
;;;;;            ▀▄▄▄█▀   ▀▄▄  ▀▄▄▀█   █       ▀▄▄
;;;;;
;;;;;
;;;;;



(with-benchmark/simple
 :name "benchmark-parselynn-simple-1"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000))
 (repeating-template driver load? seq-len n-runs))
