;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <lesya:struct>
  (lesya:language:state:struct:construct
   mapping      ;; A hashmap that associates [top-level] names of constructed terms, with their syntactic representation.
   callstack    ;; Just names of variables being defined.
   )

  lesya:language:state:struct?

  (mapping lesya:language:state:mapping)
  (callstack lesya:language:state:callstack)

  )


(define (lesya:language:state:make)
  (define mapping (make-hashmap))
  (define callstack (stack-make))
  (lesya:language:state:struct:construct
   mapping callstack))

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

(define-syntax lesya:language:when
  (syntax-rules ()
    ((_ name term)
     (define name (quote term)))))

(define (lesya:language:replace-var initial-term qvarname qreplcement)
  (unless (symbol? qreplcement)
    (lesya:error 'non-symbol-in-replacement qreplcement initial-term qvarname))

  (let loop ((term initial-term))
    (cond
     ((null? term)
      term)
     ((list? term)
      (cons (car term) (map loop (cdr term))))
     ((equal? term qvarname)
      qreplcement)
     ((equal? term qreplcement)
      (lesya:error 'replacement-object-found-in-the-replacement-subject qreplcement initial-term))
     (else
      term))))

(define (lesya:error type . args)
  (define struct (lesya:language:state/p))
  (define stack (lesya:language:state:callstack struct))

  (raisu* :from "lesya:language"
          :type type
          :message (stringf "Lesya error of type ~s and arguments ~s at ~s."
                            type args (stack->list stack))
          :args (list args (stack->list stack))))

(define lesya:implication:name
  'if)

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

(define-syntax lesya:language:define-arg
  (syntax-rules (suppose set do)
    ((_  (suppose (x shape) . bodies))
     (let ((x (quote shape)))
       `(if ,x
            ,(let () . bodies))))

    ((_ (set (term varname) replacement))
     (lesya:language:replace-var term (quote varname) (quote replacement)))

    ((_ (apply implication argument))
     (lesya:language:modus-ponens implication argument))))

(define-syntax lesya:language:cons
  (syntax-rules ()
    ((_ name arg)
     (define name
       (let ()
         (define state (lesya:language:state/p))
         (define stack (lesya:language:state:callstack state))
         (define mapping (lesya:language:state:mapping state))
         (define _res (stack-push! stack (quote name)))
         (define result (lesya:language:define-arg arg))
         (stack-pop! stack)
         (when (stack-empty? stack)
           (hashmap-set! mapping (quote name) result))
         result)))))
