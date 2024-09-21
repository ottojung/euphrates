;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;;
;;
;; Throughout a lasting night of darkness
;; Ne'er shall I rest my own eyes,
;; Always searching for the guiding star,
;; The bright empress of the dark night skies.
;;
;;


(define-type9 <lesya:struct>
  (lesya:language:state:struct:construct
   mapping       ;; A hashmap that associates [top-level] names of constructed terms, with their syntactic representation.
   callstack     ;; Just names of variables being defined.
   supposedterms ;; The hypothetical terms introduced by `let` in this scope so far.
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
      (quasiquote term)))))

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

(define (lesya:error type . args)
  (define stack (lesya:get-current-stack))

  (raisu* :from "lesya:language"
          :type type
          :message (stringf "Lesya error of type ~s and arguments ~s at ~s."
                            type args (stack->list stack))
          :args (list args (stack->list stack))))

(define lesya:implication:name
  'if)

(define lesya:substitution:name
  'map)

(define (lesya:implication:make supposition conclusion)
  `(,lesya:implication:name ,supposition ,conclusion))

(define (lesya:implication:destruct implication)
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

    (values premise conclusion)))

(define (lesya:language:modus-ponens implication argument)
  (define-values (premise conclusion)
    (lesya:implication:destruct implication))

  (unless (equal? premise argument)
    (lesya:error 'non-matching-modus-ponens argument implication))

  conclusion)

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


(define-syntax lesya:language:map
  (syntax-rules ()
    ((_ implication body)
     (lesya:check-that-on-toplevel
      (let ()
        (define-values (premise conclusion)
          (lesya:implication:destruct (quasiquote implication)))

        (unless (symbol? premise)
          (lesya:error 'non-symbol-1-in-map premise conclusion body))

        (lesya:language:beta-reduce
         body premise conclusion))))))


(define-type9 <lesya:list>
  (lesya:language:list a b) lesya:language:list?
  (a lesya:language:list:a)
  (b lesya:language:list:b)
  )


(define (lesya:language:eval expr)
  (cond
   ((lesya:language:list? expr)
    (let ()
      (define fun (lesya:language:list:a expr))
      (define argument (lesya:language:list:b expr))
      (lesya:language:modus-ponens fun argument)))

   ((and (pair? expr) (list? expr))
    (let ()
      (define operation (car expr))

      (cond
       ((equal? operation lesya:substitution:name)
        (let ()
          (define-tuple (operation implication body) expr)
          (define-values (premise conclusion)
            (lesya:implication:destruct implication))

          (lesya:language:beta-reduce
           body premise conclusion)))

       (else
        (lesya:error 'unknown-operation-in-eval operation expr)))))

   (else
    (lesya:error 'non-expression-in-eval expr))))
