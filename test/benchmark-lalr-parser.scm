
;;
;; this file is like test-lalr-parser-largecases.scm, but cases are even larger
;;

(define (error-procedure type message-fmt token)
  (raisu* :type 'parse-error
          :message (stringf message-fmt token)
          :args (list type token)))

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
      (make-lexical-token t #f v))
     ((> maxdepth how-deep)
      (if (< (+ 1 closecount) maxdepth)
          (begin
            (set! closecount (+ closecount 1))
            (make-lexical-token 'RPAREN #f ")"))
          '*eoi*))
     (else
      (if (equal? t 'LPAREN)
          (begin
            (set! maxdepth (+ maxdepth 1))
            (make-lexical-token 'NUM #f "1"))
          (make-lexical-token t #f v)))))

  (lambda () (next)))

(define (repeating-template driver load? seq-len)
  (define parser
    (if load?
        (cond
         ((equal? driver "lr")
          (parser-repeating-lr (vector)))
         ((equal? driver "glr")
          (parser-repeating-glr (vector)))
         (else
          (raisu 'bad-driver-type driver)))

        (lalr-parser
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (on-conflict: ,ignore)
           (driver: ,(string->symbol driver))
           (rules:
            (expr     (expr add expr) : #t
                      (term) : #t)
            (add      (+) : #t)
            (term     (NUM) : #t))))))

  (define result
    (parser (make-repeating-lexer
             seq-len
             (list (make-lexical-token 'NUM #f "5")
                   (make-lexical-token '+ #f "+")))
            error-procedure))

  (if (equal? driver "lr")
      (assert= #t result)
      (begin
        (assert (list? result))
        (assert (not (null? result))))))


(define (brackets-template driver load? tree-depth)
  (define parser
    (if load?
        (cond
         ((equal? driver "lr")
          (parser-branching-lr (vector)))
         ((equal? driver "glr")
          (parser-branching-glr (vector)))
         (else
          (raisu 'bad-driver-type driver)))

        (lalr-parser
         `((tokens: ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
           (driver: ,(string->symbol driver))
           (on-conflict: ,ignore)
           (rules:
            (expr     (expr add expr) : #t
                      (LPAREN expr RPAREN) : #t
                      (term) : #t)
            (add      (+) : #t)
            (term     (NUM) : #t))))))

 (define result
   (parser (make-brackets-lexer tree-depth) error-procedure))

 (if (equal? driver "lr")
     (assert= #t result)
     (begin
       (assert (list? result))
       (assert (not (null? result))))))


;;;;;;;;;;;;
;;
;; START
;;


(with-benchmark/simple
 :name "benchmark-lalr-parser-1"
 :inputs ((driver "lr") (load? #f) (seq-len 300000))
 (repeating-template driver load? seq-len))


(with-benchmark/simple
 :name "benchmark-lalr-parser-2"
 :inputs ((driver "glr") (load? #f) (seq-len 23))
 (repeating-template driver load? seq-len))


(with-benchmark/simple
 :name "benchmark-lalr-parser-3"
 :inputs ((driver "lr") (load? #f) (tree-depth 50000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-lalr-parser-4"
 :inputs ((driver "glr") (load? #f) (tree-depth 50000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-lalr-parser-5"
 :inputs ((driver "lr") (load? #t) (seq-len 300000))
 (repeating-template driver load? seq-len))


(with-benchmark/simple
 :name "benchmark-lalr-parser-6"
 :inputs ((driver "glr") (load? #t) (seq-len 23))
 (repeating-template driver load? seq-len))


(with-benchmark/simple
 :name "benchmark-lalr-parser-7"
 :inputs ((driver "lr") (load? #t) (seq-len 30000000))
 (repeating-template driver load? seq-len))


(with-benchmark/simple
 :name "benchmark-lalr-parser-8"
 :inputs ((driver "glr") (load? #t) (seq-len 27))
 (repeating-template driver load? seq-len))


(with-benchmark/simple
 :name "benchmark-lalr-parser-9"
 :inputs ((driver "lr") (load? #t) (tree-depth 50000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-lalr-parser-10"
 :inputs ((driver "glr") (load? #t) (tree-depth 50000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-lalr-parser-11"
 :inputs ((driver "lr") (load? #t) (tree-depth 5000000))
 (brackets-template driver load? tree-depth))


(with-benchmark/simple
 :name "benchmark-lalr-parser-12"
 :inputs ((driver "glr") (load? #t) (tree-depth 5000000))
 (brackets-template driver load? tree-depth))

