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

(define olesya:language:escape/p
  (make-parameter #f))

(define-syntax olesya:language:run
  (syntax-rules ()
    ((_ . bodies)
     (call-with-current-continuation
      (lambda (k)
        (parameterize ((olesya:language:escape/p k))
          (let () . bodies))
        (list 'ok))))))

(define-syntax olesya:language:begin
  (syntax-rules ()
    ((_ . args) (let () . args))))


(define-syntax olesya:language:term
  (syntax-rules ()
    ((_ term)
     (olesya:syntax:term:make (quote term)))))


(define-syntax olesya:language:rule
  (syntax-rules ()
    ((_ premise consequence)
     (olesya:syntax:rule:make (quote premise) (quote consequence)))))


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
  (define escape (olesya:language:escape/p))
  (escape (list 'error type args)))


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
       (olesya:syntax:rule:make name result)))))


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
  (define escape (olesya:language:escape/p))
  (define-values (premise conclusion)
    (olesya:syntax:rule:destruct rule escape))

  (olesya:language:beta-reduce
   body premise conclusion))
