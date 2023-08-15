;;;
;;;; Tests for the GLR parser generator
;;;
;;
;; @created   "Fri Aug 19 11:23:48 EDT 2005"
;;

(define (syntax-error msg . args)
  (display msg (current-error-port))
  (parameterize ((current-output-port (current-error-port)))
    (for-each (cut stringf " ~A" <>) args))
  (newline (current-error-port))
  (raisu 'misc-error))


(define (make-lexer words)
  (let ((phrase words))
    (lambda ()
      (if (null? phrase)
          '*eoi*
          (let ((word (car phrase)))
            (set! phrase (cdr phrase))
            word)))))


;;;
;;;; Test 1
;;;


(define parser-1
  ;; Grammar taken from Tomita's "An Efficient Augmented-Context-Free Parsing Algorithm"
  (with-lalr-parser-conflict-handler
   (lambda _ #f)
   (lalr-parser
    `((driver: glr)
      (tokens: *n *v *d *p)
      (rules:
       (<s>  (<np> <vp>)
             (<s> <pp>))
       (<np> (*n)
             (*d *n)
             (<np> <pp>))
       (<pp> (*p <np>))
       (<vp> (*v <np>)))))))


(define *phrase-1* '(*n *v *d *n *p *d *n *p *d *n *p *d *n))

(define (test-1)
  (parser-1 (make-lexer *phrase-1*) syntax-error))


;;;
;;;; Test 2
;;;


(define parser-2
  ;; The dangling-else problem
  (with-lalr-parser-conflict-handler
   (lambda _ #f)
   (lalr-parser
    `((driver: glr)
      (tokens: (nonassoc: if then else e s))
      (rules:
       (<s> (s)
            (if e then <s>)
            (if e then <s> else <s>)))))))


(define *phrase-2* '(if e then if e then s else s))

(define (test-2)
  (parser-2 (make-lexer *phrase-2*) syntax-error))

(define (assert-length l n test-name)
  (assert= (length l) n))

(assert-length (test-1) 14 1)
(assert-length (test-2) 2 2)
