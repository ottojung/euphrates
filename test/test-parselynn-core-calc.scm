;;;
;;;; Simple calculator in Scheme
;;;
;;
;;   This program illustrates the use of the lalr-scm parser generator
;; for Scheme. It is NOT robust, since calling a function with
;; the wrong number of arguments may generate an error that will
;; cause the calculator to crash.


;;;
;;;;   The LALR(1) parser
;;;

(define (display-result v)
  (if v
      (begin
        (display v)
        (newline)))
  (display-prompt))

;;;
;;;;   Environment management
;;;


(define *env* (list (cons '$$ 0)))


(define (init-bindings)
  (set-cdr! *env* '())
  (add-binding 'cos cos)
  (add-binding 'sin sin)
  (add-binding 'tan tan)
  (add-binding 'expt expt)
  (add-binding 'sqrt sqrt))


(define (add-binding var val)
  (set! *env* (cons (cons var val) *env*))
  val)


(define (get-binding var)
  (let ((p (assq var *env*)))
    (if p
        (cdr p)
        0)))


(define (invoke-proc proc-name args)
  (let ((proc (get-binding proc-name)))
    (if (procedure? proc)
        (apply proc args)
        (begin
          (display "ERROR: invalid procedure:")
          (display proc-name)
          (newline)
          0))))

(define calc-parser
  (parselynn:core

   `(
     ;; ;; output the LALR table to calc.out
     ;; (parameterize ((parselynn:core:output-table-port/p (open-output-file "/tmp/calc.out"))) ...)

     (driver: (LR 1))

     (tokens: ID NUM = LPAREN RPAREN NEWLINE COMMA + - * /)

     (rules:
      (lines    (lines line) : (,display-result $2)
                (line)       : (,display-result $1))


      ;; --- rules
      (line     (assign NEWLINE)        : $1
                (expr   NEWLINE)        : $1
                (NEWLINE)               : #f
                (error  NEWLINE)        : #f)

      (assign   (ID = expr)             : (,add-binding $1 $3))

      (expr     (term + expr)           : (+ $1 $3)
                (term - expr)           : (- $1 $3)
                (term * expr)           : (* $1 $3)
                (term / expr)           : (/ $1 $3)
                ;; (- expr)                : (- $2)
                (term)                  : $1
                )

      (term     (ID)                    : (,get-binding $1)
                (ID LPAREN args RPAREN) : (,invoke-proc $1 $3)
                (NUM)                   : $1
                (LPAREN expr RPAREN)    : $2)

      (args     ()                      : (list)
                (expr arg-rest)         : (cons $1 $2))

      (arg-rest (COMMA expr arg-rest)   : (cons $2 $3)
                ()                      : (list))))))


;;;
;;;;   The lexer
;;;

(define (force-output) #f)
(define (port-line port) '??)
(define (port-column port) '??)

(define (make-lexer errorp)
  (lambda ()
    (letrec ((skip-spaces
              (lambda ()
                (let loop ((c (peek-char)))
                  (if (and (not (eof-object? c))
                           (or (char=? c #\space) (char=? c #\tab)))
                      (begin
                        (read-char)
                        (loop (peek-char)))))))
             (read-number
              (lambda (l)
                (let ((c (peek-char)))
                  (if (char-numeric? c)
                      (read-number (cons (read-char) l))
                      (string->number (apply string (reverse l)))))))
             (read-id
              (lambda (l)
                (let ((c (peek-char)))
                  (if (char-alphabetic? c)
                      (read-id (cons (read-char) l))
                      (string->symbol (apply string (reverse l))))))))

      ;; -- skip spaces
      (skip-spaces)
      ;; -- read the next token
      (let loop ()
        (let* ((location (make-source-location "*stdin*" (port-line (current-input-port)) (port-column (current-input-port)) -1 -1))
               (c (read-char)))
          (cond ((eof-object? c)      '*eoi*)
                ((char=? c #\newline) (parselynn:token:make 'NEWLINE location #f))
                ((char=? c #\+)       (parselynn:token:make '+       location #f))
                ((char=? c #\-)       (parselynn:token:make '-       location #f))
                ((char=? c #\*)       (parselynn:token:make '*       location #f))
                ((char=? c #\/)       (parselynn:token:make '/       location #f))
                ((char=? c #\=)       (parselynn:token:make '=       location #f))
                ((char=? c #\,)       (parselynn:token:make 'COMMA   location #f))
                ((char=? c #\()       (parselynn:token:make 'LPAREN  location #f))
                ((char=? c #\))       (parselynn:token:make 'RPAREN  location #f))
                ((char-numeric? c)    (parselynn:token:make 'NUM     location (read-number (list c))))
                ((char-alphabetic? c) (parselynn:token:make 'ID      location (read-id (list c))))
                (else
                 (errorp 'lexer-error "PARSE ERROR : illegal character: " c)
                 (skip-spaces)
                 (loop))))))))



;;;
;;;;   The main program
;;;


(define (display-prompt)
  (display "[calculator]> ")
  (force-output))


(define calc
  (lambda ()
    (call-with-current-continuation
     (lambda (k)
       (display "********************************") (newline)
       (display "*  Mini calculator in Scheme   *") (newline)
       (display "*                              *") (newline)
       (display "* Enter expressions followed   *") (newline)
       (display "* by [RETURN] or 'quit()' to   *") (newline)
       (display "* exit.                        *") (newline)
       (display "********************************") (newline)
       (init-bindings)
       (add-binding 'quit (lambda () (k #t)))
       (letrec ((errorp
                 (lambda (type message . args)
                   (display message)
                   (if (and (pair? args)
                            (parselynn:token? (car args)))
                       (let ((token (car args)))
                         (display (or (parselynn:token:value token)
                                      (parselynn:token:category token)))
                         (let ((source (parselynn:token:source token)))
                           (if (source-location? source)
                               (let ((line (source-location-line source))
                     (column (source-location-column source)))
                 (if (and (number? line) (number? column))
                     (begin
                       (display " (at line ")
                       (display line)
                       (display ", column ")
                       (display (+ 1 column))
                       (display ")")))))))
                       (for-each display args))
                   (newline)))
                (start
                 (lambda ()
                   (parselynn-run/with-error-handler
                    calc-parser errorp
                    (make-lexer errorp)))))
     (display-prompt)
         (start))))))


(assert=
 "********************************
*  Mini calculator in Scheme   *
*                              *
* Enter expressions followed   *
* by [RETURN] or 'quit()' to   *
* exit.                        *
********************************
[calculator]> 4
[calculator]> 869
[calculator]> "

 (with-output-stringified
  (with-string-as-input
   "2 + 2
46+ 823
quit()
"
   (calc))))
