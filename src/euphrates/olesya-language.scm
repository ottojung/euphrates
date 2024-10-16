;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;;
;;
;; My only weapon, dear words that I cherish,
;; We must ensure that not both of us perish!
;; Wielded by brothers we do not yet know,
;; You may do better in routing the foe.
;;
;;


;;
;; ===============================================
;; TODO: implement following design:
;;
;; (let x (term P)
;;      (rule x x))
;;
;; ->
;;
;; (map (rule x (term P))
;;      (rule x x))
;;
;; via:
;;
;; - (let x T (rule T x))
;; - (rule (let x T B) (map (rule x T) B))
;;
;; example transform:
;;
;; (rule (let x (term P) B)
;;       (let x (term Q) B))
;;
;; via:
;;
;; (rule (rule P Q)
;;       (rule (let x P B) (let x Q B)))
;;
;; ===============================================
;;


;; TODO: remove this struct.
(define-type9 <olesya:struct>
  (olesya:language:state:struct:construct
   callstack     ;; Just names of variables being defined.
   supposedterms ;; The hypothetical terms introduced by `let` in this scope so far.
   escape        ;; Continuation that returns to the top.
   )

  olesya:language:state:struct?

  (callstack olesya:language:state:callstack)
  (supposedterms olesya:language:state:supposedterms)
  (escape olesya:language:state:escape)

  )


(define (olesya:language:state:make escape)
  (define callstack (stack-make))
  (define supposedterms (stack-make))
  (olesya:language:state:struct:construct
   callstack supposedterms escape))

(define olesya:language:state/p
  (make-parameter #f))

(define-syntax olesya:language:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (define state (olesya:language:state:make k))
        (parameterize ((olesya:language:state/p state))
          (let () . bodies))
        (list 'ok))))))

(define-syntax olesya:language:begin
  (syntax-rules ()
    ((_ . args) (let () . args))))


(define (olesya:get-current-stack)
  (define struct (olesya:language:state/p))
  (olesya:language:state:callstack struct))


(define (olesya:currently-hyphothetical?)
  (define struct (olesya:language:state/p))
  (define supposedterms (olesya:language:state:supposedterms struct))
  (not (stack-empty? supposedterms)))


(define-syntax olesya:check-that-on-toplevel
  (syntax-rules ()
    ((_ body)
     (if (olesya:currently-hyphothetical?)
         (olesya:error 'only-allowed-on-top-level
                      (stringf "This operation is only allowed on toplevel: ~s." (quote body)))
         body))))


(define-syntax olesya:language:term
  (syntax-rules ()
    ((_ term)
     (list olesya:term:name (quote term)))))


(define (olesya:rule:make premise consequence)
  (list olesya:rule:name premise consequence))


(define-syntax olesya:language:rule
  (syntax-rules ()
    ((_ premise consequence)
     (olesya:rule:make (quote premise) (quote consequence)))))


(define (olesya:language:beta-reduce term qvarname qreplcement)
  (let loop ((term term))
    (cond
     ((equal? term qvarname)
      qreplcement)
     ((null? term)
      term)
     ((list? term)
      (cons (car term) (map loop (cdr term))))
     (else
      term))))


(define (olesya:error type . args)
  (define state (olesya:language:state/p))
  (define stack (olesya:language:state:callstack state))
  (define escape (olesya:language:state:escape state))

  (escape (list 'error type args (stack->list stack))))


(define olesya:substitution:name
  'map)

(define olesya:eval:name
  'eval)

(define olesya:rule:name
  'rule)

(define olesya:term:name
  'term)

(define olesya:let:name
  'let)

(define olesya:begin:name
  'begin)


(define (olesya:rule:check rule)
  (or
   (and (not (list? rule))
        (list 'not-a-term-in-rule rule))
   (and (not (pair? rule))
        (olesya:error 'null-in-rule rule))
   (and (not (list-length= 3 rule))
        (list 'bad-length-of-rule-in-modus-ponens rule))
   (let ()
     (define-tuple (predicate premise conclusion) rule)
     (and (not (equal? predicate olesya:rule:name))
          (list 'wrong-constructor-for-rule rule)))))


(define (olesya:rule? rule)
  (not (olesya:rule:check rule)))


(define (olesya:rule:destruct rule)
  (define error (olesya:rule:check rule))
  (when error
    (apply olesya:error error))

  (let ()
    (define-tuple (predicate premise conclusion) rule)
    (values premise conclusion)))


(define (olesya:substitution:check substitution)
  (or
   (and (not (list? substitution))
        (list 'not-a-term-in-substitution substitution))
   (and (not (pair? substitution))
        (olesya:error 'null-in-substitution substitution))
   (and (not (list-length= 3 substitution))
        (list 'bad-length-of-substitution-in-modus-ponens substitution))
   (let ()
     (define-tuple (predicate rule subject) substitution)
     (and (not (equal? predicate olesya:substitution:name))
          (list 'wrong-constructor-for-substitution substitution)))))


(define (olesya:substitution? substitution)
  (not (olesya:substitution:check substitution)))


(define (olesya:substitution:destruct substitution)
  (define error (olesya:substitution:check substitution))
  (when error
    (apply olesya:error error))

  (let ()
    (define-tuple (predicate rule subject) substitution)
    (values rule subject)))


(define-syntax olesya:language:define
  (syntax-rules ()
    ((_ name expr)
     (define name expr))))


(define-syntax olesya:language:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((name expr) . lets) . bodies)
     (let ()
       (define name expr)
       (define result (olesya:language:let lets . bodies))
       (olesya:rule:make name result)))))


(define-syntax olesya:language:=
  (syntax-rules ()
    ((_ a b)
     (let ()
       (define a* a)
       (define b* (quote b))
       (if (equal? a* b*) a*
           (olesya:error
            'terms-are-not-equal
            (list 'context:
                  'actual: a*
                  'expected: b*
                  'endcontext:)))))))


(define (olesya:language:map rule body)
  (define-values (premise conclusion)
    (olesya:rule:destruct rule))

  (olesya:language:beta-reduce
   body premise conclusion))
