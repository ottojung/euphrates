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
    ((_ . args) (begin . args))))


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


(define-syntax olesya:language:axiom
  (syntax-rules ()
    ((_ term)
     (quote term))))


(define (olesya:language:beta-reduce initial-term qvarname qreplcement)
  (let loop ((term initial-term))
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

(define olesya:specify:name
  'rule)

(define (olesya:specify:make supposition conclusion)
  `(,olesya:specify:name ,supposition ,conclusion))


(define (olesya:specify:check specify)
  (or
   (and (not (list? specify))
        (list 'not-a-term-in-specify specify))
   (and (not (pair? specify))
        (olesya:error 'null-in-specify specify))
   (and (not (list-length= 3 specify))
        (list 'bad-length-of-specify-in-modus-ponens specify))
   (let ()
     (define-tuple (predicate premise conclusion) specify)

     (and (not (equal? predicate olesya:specify:name))
          (list 'non-specify-in-modus-ponens specify)))))


(define (olesya:specify? specify)
  (not (olesya:specify:check specify)))


(define (olesya:specify:destruct specify)
  (define error (olesya:specify:check specify))
  (when error
    (apply olesya:error error))

  (let ()
    (define-tuple (predicate premise conclusion) specify)
    (values premise conclusion)))


(define (olesya:specify qvarname qsubterm)
  (unless (symbol? qvarname)
    (olesya:error 'non-symbol-in-specify qvarname qsubterm))

  (olesya:specify:make qvarname qsubterm))


(define-syntax olesya:language:specify
  (syntax-rules ()
    ((_ varname subterm)
     (olesya:specify (quote varname) (quote subterm)))))


(define-syntax olesya:language:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))))


(define-syntax olesya:language:define
  (syntax-rules ()
    ((_ name arg)
     (define name
       (let ()
         (define stack (olesya:get-current-stack))
         (define _res (stack-push! stack (quote name)))
         (define result arg)
         (stack-pop! stack)
         result)))))


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
    (olesya:specify:destruct rule))

  (olesya:language:beta-reduce
   body premise conclusion))


(define (olesya:language:eval expr)
  (cond
   ((and (pair? expr) (list? expr))
    (let ()
      (define operation (car expr))

      (cond
       ((equal? operation olesya:substitution:name)
        (let ()
          (define-tuple (operation rule body) expr)
          (olesya:language:map rule body)))

       (else
        (olesya:error 'unknown-operation-in-eval operation expr)))))

   (else
    (olesya:error 'non-expression-in-eval expr))))
