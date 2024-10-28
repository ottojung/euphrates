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

(define olesya:language:state/p
  (make-parameter #f))

(define-syntax olesya:language:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (parameterize ((olesya:language:state/p k))
          (let () . bodies))
        (list 'ok))))))

(define-syntax olesya:language:begin
  (syntax-rules ()
    ((_ . args) (let () . args))))


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
  (define escape (olesya:language:state/p))
  (escape (list 'error type args)))


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
