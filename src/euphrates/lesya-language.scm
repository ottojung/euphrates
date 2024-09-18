;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <lesya:struct>
  (lesya:language:state:struct:construct
   mapping       ;; A hashmap that associates [top-level] names of constructed terms, with their syntactic representation.
   callstack     ;; Just names of variables being defined.
   supposedterms ;; The hypothetical terms introduced by `lambda` in this scope so far.
   )

  lesya:language:state:struct?

  (mapping lesya:language:state:mapping)
  (callstack lesya:language:state:callstack)
  (supposedterms lesya:language:state:supposedterms)

  )


(define (lesya:language:state:make)
  (define mapping (make-hashmap))
  (define callstack (stack-make))
  (define supposedterms (stack-make))
  (lesya:language:state:struct:construct
   mapping callstack supposedterms))

(define lesya:language:state/p
  (make-parameter #f))

(define-syntax lesya:language:run
  (syntax-rules ()
    ((_ . bodies)
     (let ()
       (define state (lesya:language:state:make))
       (parameterize ((lesya:language:state/p state))
         (let () . bodies))
       (lesya:language:state:mapping state)))))

(define-syntax lesya:language:begin
  (syntax-rules ()
    ((_ . args) (begin . args))))


(define (lesya:get-current-stack)
  (define struct (lesya:language:state/p))
  (lesya:language:state:callstack struct))


(define (lesya:currently-hyphothetical?)
  (define struct (lesya:language:state/p))
  (define supposedterms (lesya:language:state:supposedterms struct))
  (not (stack-empty? supposedterms)))


(define-syntax lesya:check-that-on-toplevel
  (syntax-rules ()
    ((_ body)
     (if (lesya:currently-hyphothetical?)
         (lesya:error 'only-allowed-on-top-level
                      (stringf "This operation is only allowed on toplevel: ~s." (quote body)))
         body))))


(define-syntax lesya:language:axiom
  (syntax-rules ()
    ((_ term)
     (lesya:check-that-on-toplevel
      (quote term)))))

(define (lesya:language:alpha-convert initial-term qvarname qreplcement)
  (unless (symbol? qvarname)
    (lesya:error 'non-symbol-1-in-alpha-convert qvarname initial-term qreplcement))

  (unless (symbol? qreplcement)
    (lesya:error 'non-symbol-2-in-alpha-convert qreplcement initial-term qvarname))

  (let loop ((term initial-term))
    (cond
     ((null? term)
      term)
     ((list? term)
      (cons (car term) (map loop (cdr term))))
     ((equal? term qreplcement)
      (lesya:error 'replacement-object-found-in-the-replacement-subject qreplcement initial-term))
     ((equal? term qvarname)
      qreplcement)
     (else
      term))))

(define (lesya:language:beta-reduce initial-term qvarname qreplcement)
  (unless (symbol? qvarname)
    (lesya:error 'non-symbol-1-in-beta-reduce qvarname initial-term qreplcement))

  (let loop ((term initial-term))
    (cond
     ((null? term)
      term)
     ((list? term)
      (cons (car term) (map loop (cdr term))))
     ((equal? term qreplcement)
      (lesya:error 'replacement-object-found-in-the-replacement-subject qreplcement initial-term))
     ((equal? term qvarname)
      qreplcement)
     (else
      term))))

(define (lesya:error type . args)
  (define stack (lesya:get-current-stack))

  (raisu* :from "lesya:language"
          :type type
          :message (stringf "Lesya error of type ~s and arguments ~s at ~s."
                            type args (stack->list stack))
          :args (list args (stack->list stack))))

(define lesya:implication:name
  'if)

(define lesya:negation:name
  'not)

(define (lesya:negation:make term)
  `(,lesya:negation:name ,term))

(define (lesya:implication:make supposition conclusion)
  `(,lesya:implication:name ,supposition ,conclusion))

(define (lesya:false? term)
  (equal? term '(false)))

(define (lesya:language:modus-ponens implication argument)
  (unless (list? implication)
    (lesya:error 'not-a-term-in-implication implication))

  (unless (pair? implication)
    (lesya:error 'null-in-implication implication))

  (unless (list-length= 3 implication)
    (lesya:error 'bad-length-of-implication-in-modus-ponens implication))

  (let ()
    (define-tuple (predicate premise conclusion) implication)

    (unless (equal? predicate lesya:implication:name)
      (lesya:error 'non-implication-in-modus-ponens implication))

    (unless (equal? premise argument)
      (lesya:error 'non-matching-modus-ponens argument implication))

    conclusion))

(define-syntax lesya:language:alpha
  (syntax-rules ()
    ((_ (term varname) replacement)
     (lesya:check-that-on-toplevel
      (lesya:language:alpha-convert
       term (quote varname) (quote replacement))))))

(define-syntax lesya:language:beta
  (syntax-rules ()
    ((_ (term varname) replacement)
     (lesya:check-that-on-toplevel
      (lesya:language:beta-reduce
       term (quote varname) (quote replacement))))))

(define (lesya:language:apply implication argument)
  (lesya:language:modus-ponens implication argument))

(define (lesya:currently-at-toplevel?)
  (define stack (lesya:get-current-stack))
  (and (stack-empty? stack)
       (not (lesya:currently-hyphothetical?))))

(define-syntax lesya:language:define
  (syntax-rules ()
    ((_ name arg)
     (define name
       (let ()
         (define state (lesya:language:state/p))
         (define stack (lesya:language:state:callstack state))
         (define mapping (lesya:language:state:mapping state))
         (define _res (stack-push! stack (quote name)))
         (define result arg)
         (stack-pop! stack)
         (when (lesya:currently-at-toplevel?)
           (hashmap-set! mapping (quote name) result))
         result)))))

(define-syntax lesya:language:let
  (syntax-rules ()
    ((_ () . bodies)
     (let () . bodies))

    ((_  ((x shape) . lets) . bodies)
     (let ()
       (define x (quote shape))
       (define state (lesya:language:state/p))
       (define supposedterms (lesya:language:state:supposedterms state))
       (define _re (stack-push! supposedterms x))
       (define result (lesya:language:let lets . bodies))
       (stack-pop! supposedterms)
       (lesya:implication:make x result)))))


(define-syntax lesya:language:when
  (syntax-rules ()
    ((_ a b)
     (let ()
       (define a* a)
       (define b* (quote b))
       (if (equal? a* b*)
           a*
           (lesya:error 'terms-are-not-equal a* b*))))))
