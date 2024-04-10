
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



(define (repeating-template-2 driver load? seq-len n-runs)
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
           (case (remainder count 7)
             ((1) #\4)
             ((2) #\2)
             ((3) #\+)
             ((4) #\x)
             ((5) #\-)
             ((6) #\y)
             ((0) #\*)))
         constant-s))
      normal-s))

  (with-benchmark/timestamp "constructed input")

  (define parser
    (parselynn/simple
     `(:grammar
       ( expr = expr add expr / term
         add = (class (or (= #\+) (= #\-) (= #\*) (= #\/)))
         term = id / num
         id = idstart idcont / idstart
         idstart = (class alphabetic)
         idcont = idchar idcont / idchar
         idchar = (class (and alphanum (not (= #\0))))
         num = dig num / dig
         dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

       :driver ,(string->symbol driver))))

  (with-benchmark/timestamp "constructed parser")
  (run/generic parser input n-runs))



(define (repeating-template-3 driver load? seq-len n-runs)
  (define _8123 (assert= driver "lr"))
  (define _4632 (assert= load? #f))

  (define input
    (let ()
      (define input-template
        " 42 + x2 * \"good \\\n 777 \\\" quote\"-  y* 59 + \"a \\\" quote\"  + x  ")
      (define count -1)
      (define constant-s (make-string seq-len))
      (define normal-s
        (string-map
         (lambda (c)
           (set! count (+ 1 count))
           (define denom (+ 1 (string-length input-template)))
           (define num (remainder count denom))
           (if (< num (string-length input-template))
               (string-ref input-template num)
               #\*))
         constant-s))
      normal-s))

  (with-benchmark/timestamp "constructed input")

  (define parser
    (parselynn/simple
     `(:grammar
       ( expr = expr add expr / term / space expr / expr space
         add = (class (or (= #\+) (= #\-) (= #\*) (= #\/)))
         term = id / num / string
         id = idstart idcont / idstart
         idstart = (class alphabetic)
         idcont = idchar idcont / idchar
         idchar = (class (and alphanum (not (= #\0))))
         num = dig num / dig
         dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
         space = (class whitespace)
         string = "\"" string-inner* "\""
         string-inner = "\\" (class any)
         /              string-no-escape
         string-no-escape = (class (and any (not (= #\")) (not (= #\\))))
         )

       :inline (num id term string add)
       :join (num id string)
       :flatten (term expr)
       :skip (space)

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


(with-benchmark/simple
 :name "benchmark-parselynn-simple-2"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000))
 (repeating-template-2 driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-3"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000))
 (repeating-template-3 driver load? seq-len n-runs))
