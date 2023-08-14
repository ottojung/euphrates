
(define hidden-imports
  '(glr-driver lr-driver
               vector vector-ref let* list-ref
               lexical-token?
               force-output
               lexical-token-value
               lexical-token-source))

(define (make-lexer)
  (lambda ()
    (letrec ((read-number
              (lambda (l)
                (let ((c (peek-char)))
                  (if (and (char? c) (char-numeric? c))
                      (read-number (cons (read-char) l))
                      (string->number (apply string (reverse l)))))))
             (read-id
              (lambda (l)
                (let ((c (peek-char)))
                  (if (and (char? c) (char-alphabetic? c))
                      (read-id (cons (read-char) l))
                      (apply string (reverse l)))))))

      ;; -- read the next token
      (let loop ()
        (let* ((location (make-source-location "*stdin*" 'unknown-line 'unknown-column -1 -1))
               (c (read-char)))
          (cond ((eof-object? c)      '*eoi*)
                ((char=? c #\newline) (make-lexical-token 'NEWLINE location 'NEWLINE))
                ((char-whitespace? c) (make-lexical-token 'SPACE   location 'SPACE))
                ((char=? c #\+)       (make-lexical-token '+       location (string c)))
                ((char=? c #\-)       (make-lexical-token '-       location (string c)))
                ((char=? c #\*)       (make-lexical-token '*       location (string c)))
                ((char=? c #\/)       (make-lexical-token '/       location (string c)))
                ((char=? c #\=)       (make-lexical-token '=       location (string c)))
                ((char=? c #\,)       (make-lexical-token 'COMMA   location (string c)))
                ((char=? c #\()       (make-lexical-token 'LPAREN  location (string c)))
                ((char=? c #\))       (make-lexical-token 'RPAREN  location (string c)))
                ((char-numeric? c)    (make-lexical-token 'NUM     location (read-number (list c))))
                ((char-alphabetic? c) (make-lexical-token 'ID      location (read-id (list c))))
                (else
                 (raisu
                  'lex-error
                  (stringf "PARSE ERROR : illegal character: ~s" c)
                  c)
                 (loop))))))))

(define (error-procedure . args)
  (raisu
   'parse-error
   (stringf "PARSE ERROR : ~s" args)
   args))

(define-syntax test-parser
  (syntax-rules ()
    ((_ parser-rules input expected-output)
     (let ()
       (define parser
         (lalr-parser
          (expect: 1000)

          ;; --- tokens
          (ID NUM = + - * / LPAREN RPAREN SPACE NEWLINE COMMA)
          ;; --- rules
          . parser-rules))

       (define result
         (run-input parser input))

       (assert= result expected-output)))))

(define (run-input parser input)
  (with-string-as-input
   input (parser (make-lexer) error-procedure)))

(test-parser
 ((exprs    (exprs expr) : (list 'exprs $1 $2)
            (expr) : (list 'exprs $1))
  (expr     (SPACE) : (list 'expr $1)
            (ID) : (list 'expr $1)))

 "ida idb idc longerid"

 '(exprs (exprs (exprs (exprs (exprs (exprs (exprs (expr "ida")) (expr SPACE)) (expr "idb")) (expr SPACE)) (expr "idc")) (expr SPACE)) (expr "longerid"))

 )

(test-parser
 ((lines    (line lines) : (list 'lines $1 $2)
            (line)       : (list 'lines $1)
            (exprs)      : (list 'lines $1))
  (line     (exprs line) : (list 'line $1 $2)
            (NEWLINE)    : (list 'line $1))
  (exprs    (exprs expr) : (list 'exprs $1 $2)
            (expr) : (list 'exprs $1))
  (expr     (SPACE) : (list 'expr $1)
            (ID) : (list 'expr $1)))

  "idala idbla idcla longeridla
idblb idclb longeridlb"

  '(lines (line (exprs (exprs (exprs (exprs (exprs (exprs (exprs (expr "idala")) (expr SPACE)) (expr "idbla")) (expr SPACE)) (expr "idcla")) (expr SPACE)) (expr "longeridla")) (line NEWLINE)) (lines (exprs (exprs (exprs (exprs (exprs (expr "idblb")) (expr SPACE)) (expr "idclb")) (expr SPACE)) (expr "longeridlb"))))

 )
