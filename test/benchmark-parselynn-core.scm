
;;
;; this file is like test-parselynn:core:largecases.scm, but cases are even larger
;;

(define (iterate-results iter)
  (let loop () (when (iter) (loop))))

(define (make-repeating-lexer for-how-long repeating-tokens)
  (define buf repeating-tokens)
  (define i for-how-long)
  (define stop (if (even? for-how-long) 0 1))

  (define (next)
    (cond
     ((null? buf)
      (set! buf repeating-tokens)
      (next))
     ((< i stop) '*eoi*)
     (else
      (let ((t (car buf)))
        (set! buf (cdr buf))
        (set! i (- i 1))
        t))))

  (when (null? repeating-tokens)
    (raisu 'bad-repeating-tokens repeating-tokens))

  (lambda () (next)))

(define (make-brackets-lexer how-deep)
  (define i 0)
  (define maxdepth 0)
  (define closecount 0)
  (define cycle-tokens #(LPAREN NUM +))
  (define cycle-values #("(" "5" "+"))
  (define final 'NUM)

  (define (next)
    (define imod (modulo i (vector-length cycle-tokens)))
    (define t (vector-ref cycle-tokens imod))
    (define v (vector-ref cycle-values imod))
    (set! i (+ 1 i))

    (cond
     ((< maxdepth how-deep)
      (when (equal? t 'LPAREN)
        (set! maxdepth (+ maxdepth 1)))
      (parselynn:token:make t #f v))
     ((> maxdepth how-deep)
      (if (< (+ 1 closecount) maxdepth)
          (begin
            (set! closecount (+ closecount 1))
            (parselynn:token:make 'RPAREN #f ")"))
          '*eoi*))
     (else
      (if (equal? t 'LPAREN)
          (begin
            (set! maxdepth (+ maxdepth 1))
            (parselynn:token:make 'NUM #f "1"))
          (parselynn:token:make t #f v)))))

  (lambda () (next)))

(define (run/generic driver parser make-lexer n-runs)
  (let loop ((i n-runs))
    (when (< 0 i)
      (let ()
        (define lexer
          (make-lexer))

        (when (= i n-runs)
          (with-benchmark/timestamp "constructed lexer"))

        (define result
          (parselynn-run parser lexer))

        (if (< 1 i)
            (loop (- i 1))
            (let ()
              (with-benchmark/timestamp "parsed input")
              (cond
               ((equal? driver 'lr)
                (assert= #t result))
               ((equal? driver 'glr)
                (assert (procedure? result))
                (assert= #t (result 'get))
                (iterate-results result))
               (else
                (raisu 'unrecognized-driver driver)))))))))

(define (repeating-template driver load? seq-len n-runs)
  (define parser
    (if load?
        (cond
         ((equal? driver "lr")
          (parselynn:core:deserialize/lists parser-repeating-lr))
         ((equal? driver "glr")
          (parselynn:core:deserialize/lists parser-repeating-glr))
         (else
          (raisu 'bad-driver-type driver)))

        (parameterize ((parselynn:core:conflict-handler/p ignore))
          (parselynn:core
           `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
             (driver: ,(string->symbol driver))
             (results: ,(if (equal? driver "glr") 'all 'first))
             (rules:
              (expr     (expr add expr) : #t
                        (term) : #t)
              (add      (+) : #t)
              (term     (NUM) : #t)))))))

  (with-benchmark/timestamp "constructed parser")

  (define make-lexer
    (lambda _
      (make-repeating-lexer
       seq-len
       (list (parselynn:token:make 'NUM #f "5")
             (parselynn:token:make '+ #f "+")))))

  (run/generic (string->symbol driver)
               parser make-lexer n-runs))


(define (brackets-template driver load? tree-depth)
  (define parser
    (if load?
        (cond
         ((equal? driver "lr")
          (parselynn:core:deserialize/lists parser-branching-lr))
         ((equal? driver "glr")
          (parselynn:core:deserialize/lists parser-branching-glr))
         (else
          (raisu 'bad-driver-type driver)))

        (parameterize ((parselynn:core:conflict-handler/p ignore))
          (parselynn:core
           `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
             (driver: ,(string->symbol driver))
             (results: ,(if (equal? driver "glr") 'all 'first))
             (rules:
              (expr     (expr add expr) : #t
                        (LPAREN expr RPAREN) : #t
                        (term) : #t)
              (add      (+) : #t)
              (term     (NUM) : #t)))))))

  (with-benchmark/timestamp "constructed parser")

  (define lexer
    (make-brackets-lexer tree-depth))

  (with-benchmark/timestamp "constructed lexer")

  (define result
    (parselynn-run parser lexer))

  (with-benchmark/timestamp "got first result")

 (if (equal? driver "lr")
     (assert= #t result)
     (begin
       (assert (procedure? result))
       (assert= #t (result 'get))
       (iterate-results result))))


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
 :name "benchmark-parselynn-1"
 :inputs ((driver "lr") (load? #f) (seq-len 300000) (n-runs 1))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-2"
 :inputs ((driver "glr") (load? #f) (seq-len 23) (n-runs 1))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-3"
 :inputs ((driver "lr") (load? #f) (tree-depth 50000) (n-runs 1))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-parselynn-4"
 :inputs ((driver "glr") (load? #f) (tree-depth 50000) (n-runs 1))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-parselynn-5"
 :inputs ((driver "lr") (load? #t) (seq-len 300000) (n-runs 1))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-6"
 :inputs ((driver "glr") (load? #t) (seq-len 23) (n-runs 1))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-7"
 :inputs ((driver "lr") (load? #t) (seq-len 30000000) (n-runs 1))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-8"
 :inputs ((driver "glr") (load? #t) (seq-len 29) (n-runs 1))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-9"
 :inputs ((driver "lr") (load? #t) (tree-depth 50000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-parselynn-10"
 :inputs ((driver "glr") (load? #t) (tree-depth 50000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-parselynn-11"
 :inputs ((driver "lr") (load? #t) (tree-depth 5000000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-parselynn-12"
 :inputs ((driver "glr") (load? #t) (tree-depth 5000000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-parselynn-14"
 :inputs ((driver "lr") (load? #f) (seq-len 41) (n-runs 3000))
 (repeating-template driver load? seq-len n-runs))


(with-benchmark/simple
 :name "benchmark-parselynn-15"
 :inputs ((driver "lr") (load? #t) (seq-len 41) (n-runs 3000))
 (repeating-template driver load? seq-len n-runs))
