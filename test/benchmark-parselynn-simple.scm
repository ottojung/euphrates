
(define (iterate-results iter)
  (let loop () (when (iter) (loop))))

(define (from-disk parser path)
  (parselynn:simple:save-to-disk path parser)
  (parselynn:simple:load-from-disk path))

(define (run/generic parser make-lexer n-runs)
  (let loop ((i n-runs))
    (when (< 0 i)
      (let ()
        (define lexer
          (make-lexer))

        (when (= i n-runs)
          (with-benchmark/timestamp "constructed lexer"))

        (define result
          (parselynn:simple:run/with-error-handler
           parser ignore lexer))

        (if (< 1 i)
            (loop (- i 1))
            (let ()
              (define arguments
                (parselynn:simple:struct:arguments parser))
              (define options
                (keylist->alist arguments))
              (define driver
                (assoc-or ':driver options (raisu 'impossible-8466123)))

              (with-benchmark/timestamp "parsed input")
              (cond
               ((equal? driver 'lr)
                (if (pair? result)
                    (assert= 'expr (car result))
                    (assert result)))
               ((equal? driver 'glr)
                (assert (procedure? result))
                (assert= #t (result 'get))
                (iterate-results result))
               (else
                (raisu 'unrecognized-driver driver)))))))))

(define (repeating-template driver load? seq-len n-runs string-input?)
  (define _8123 (assert= driver "lr"))

  (define (input-getter count)
    (case (remainder count 2)
      ((1) #\5)
      ((0) #\+)))

  (define make-lexer
    (if string-input?
        (lambda _
          (define count 0)
          (define adj-len (if (odd? seq-len) seq-len (+ 1 seq-len)))
          (define constant-s (make-string adj-len))
          (define normal-s
            (string-map
             (lambda _
               (set! count (+ 1 count))
               (input-getter count))
             constant-s))
          normal-s)

        (lambda _
          (define count 0)
          (define adj-len (if (odd? seq-len) seq-len (+ 1 seq-len)))
          (lambda _
            (set! count (+ 1 count))
            (if (>= (+ 1 count) adj-len)
                (eof-object)
                (input-getter count))))))

  (define parser/0
    (parselynn:simple
     `(:grammar
       ( expr = term add expr / term
         add = "+"
         term = NUM
         NUM = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

       :driver ,(string->symbol driver))))

  (define parser
    (if load?
        (from-disk
         parser/0
         "/tmp/benchmark-parselynn-simple-repeating-template.scm")
        parser/0))

  (with-benchmark/timestamp "constructed parser")
  (run/generic parser make-lexer n-runs))



(define (repeating-template-2 driver load? seq-len n-runs string-input?)
  (define _8123 (assert= driver "lr"))

  (define (input-getter count)
    (case (remainder count 7)
      ((1) #\4)
      ((2) #\2)
      ((3) #\+)
      ((4) #\x)
      ((5) #\-)
      ((6) #\y)
      ((0) #\*)))

  (define make-lexer
    (if string-input?
        (lambda _
          (define count 0)
          (define constant-s (make-string seq-len))
          (define normal-s
            (string-map
             (lambda _
               (set! count (+ 1 count))
               (input-getter count))
             constant-s))
          normal-s)

        (lambda _
          (define count 0)
          (lambda _
            (set! count (+ 1 count))
            (if (>= (+ 1 count) seq-len)
                (eof-object)
                (input-getter count))))))

  (define parser/0
    (parselynn:simple
     `(:grammar
       ( expr = term add expr / term
         add = (class (or (constant #\+) (constant #\-) (constant #\*) (constant #\/)))
         term = id / num
         id = idstart idcont / idstart
         idstart = (class alphabetic)
         idcont = idchar idcont / idchar
         idchar = (class (and alphanum (not (constant #\0))))
         num = dig num / dig
         dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9")

       :driver ,(string->symbol driver))))

  (define parser
    (if load?
        (from-disk
         parser/0
         "/tmp/benchmark-parselynn-simple-repeating-template-2.scm")
        parser/0))

  (with-benchmark/timestamp "constructed parser")
  (run/generic parser make-lexer n-runs))



(define (repeating-template-3 driver load? seq-len n-runs string-input?)
  (define _8123 (assert= driver "lr"))

  (define input-template
    " 42 + x2 * \"good \\\n 777 \\\" quote\"-  y* 59 + \"a \\\" quote\"  + x  ")
  (define (input-getter count)
    (define denom (+ 1 (string-length input-template)))
    (define num (remainder count denom))
    (if (< num (string-length input-template))
        (string-ref input-template num)
        #\*))

  (define make-lexer
    (if string-input?
        (lambda _
          (define count 0)
          (define constant-s (make-string seq-len))
          (define normal-s
            (string-map
             (lambda _
               (set! count (+ 1 count))
               (input-getter count))
             constant-s))
          normal-s)

        (lambda _
          (define count 0)
          (lambda _
            (set! count (+ 1 count))
            (if (>= (+ 1 count) seq-len)
                (eof-object)
                (input-getter count))))))

  (define parser/0
    (parselynn:simple
     `(:grammar
       ( expr = term add expr / term
         add = (class (or (constant #\+) (constant #\-) (constant #\*) (constant #\/)))
         term = baseterm / space+ baseterm / baseterm space+ / space+ baseterm space+
         baseterm = id / num / string
         id = idstart idcont / idstart
         idstart = (class alphabetic)
         idcont = idchar idcont / idchar
         idchar = (class (and alphanum (not (constant #\0))))
         num = dig num / dig
         dig = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"
         space = (class whitespace)
         string = "\"" string-inner* "\""
         string-inner = "\\" (class any)
         /              string-no-escape
         string-no-escape = (class (and any (not (constant #\")) (not (constant #\\))))
         )

       :inline (num id term string add baseterm)
       :join (num id string)
       :flatten (term expr)
       :skip (space space+)

       :driver ,(string->symbol driver))))

  (define parser
    (if load?
        (from-disk
         parser/0
          "/tmp/benchmark-parselynn-simple-repeating-template-3.scm")
        parser/0))

  (with-benchmark/timestamp "constructed parser")
  (run/generic parser make-lexer n-runs))




(define (repeating-template-1/dont-build driver load? seq-len n-runs string-input?)
  (define _8123 (assert= driver "lr"))

  (define (input-getter count)
    (case (remainder count 2)
      ((1) #\5)
      ((0) #\+)))

  (define make-lexer
    (if string-input?
        (lambda _
          (define count 0)
          (define adj-len (if (odd? seq-len) seq-len (+ 1 seq-len)))
          (define constant-s (make-string adj-len))
          (define normal-s
            (string-map
             (lambda _
               (set! count (+ 1 count))
               (input-getter count))
             constant-s))
          normal-s)

        (lambda _
          (define count 0)
          (define adj-len (if (odd? seq-len) seq-len (+ 1 seq-len)))
          (lambda _
            (set! count (+ 1 count))
            (if (>= (+ 1 count) adj-len)
                (eof-object)
                (input-getter count))))))

  (define parser/0
    (parselynn:simple
     `(:grammar

       ( expr = term add expr (call #t)
         /      term (call #t)
         add = "+" (call #t)
         term = NUM (call #t)
         NUM = "0" (call #t)
         /     "1" (call #t)
         /     "2" (call #t)
         /     "3" (call #t)
         /     "4" (call #t)
         /     "5" (call #t)
         /     "6" (call #t)
         /     "7" (call #t)
         /     "8" (call #t)
         /     "9" (call #t)
         )

       :driver ,(string->symbol driver))))

  (define parser
    (if load?
        (from-disk
         parser/0
          "/tmp/benchmark-parselynn-simple-repeating-template.scm")
        parser/0))

  (with-benchmark/timestamp "constructed parser")
  (run/generic parser make-lexer n-runs))



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
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-2"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template-2 driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-3"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template-3 driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-4"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-5"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template-2 driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-6"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template-3 driver load? seq-len n-runs string-input?))



(with-benchmark/simple
 :name "benchmark-parselynn-simple-7"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000) (string-input? #f))
 (repeating-template driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-8"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000) (string-input? #f))
 (repeating-template driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-10"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000) (string-input? #t))
 (repeating-template-1/dont-build driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-12"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000) (string-input? #f))
 (repeating-template-1/dont-build driver load? seq-len n-runs string-input?))


(with-benchmark/simple
 :name "benchmark-parselynn-simple-14"
 :inputs ((driver "lr") (load? #t) (seq-len 30000000) (n-runs 1) (string-input? #f))
 (repeating-template-1/dont-build driver load? seq-len n-runs string-input?))
