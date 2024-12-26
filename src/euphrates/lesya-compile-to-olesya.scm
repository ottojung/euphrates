;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define private:env
  (make-parameter #f))


(define (lesya:compile/->olesya program)
  (define wrapped
    (parameterize ((private:env (lexical-scope-make)))
      (local-eval program)))

  (wrapped:code wrapped))


(define (local-eval program)
  (if (symbol? program)
      (let ()
        (define default (make-unique))
        (define got (lexical-scope-ref (private:env) program default))
        (if (eq? got default)
            (raisu-fmt 'undefined-symbol "Undefined symbol ~s." (~a program))
            got))
      (ensure-wrapped
       (eval program (lesya:compile/->olesya:environment)))))


(define-type9 <wrapped>
  (wrap code interpretation) wrapped?
  (code wrapped:code)
  (interpretation wrapped:interpretation)
  )


(define (ensure-wrapped object)
  (if (wrapped? object)
      object
      (wrap object object)))


(define (unwrap wrapped)
  (values
   (wrapped:code wrapped)
   (wrapped:interpretation wrapped)))


(define (lesya:compile/->olesya:environment)
  (environment
   '(rename (euphrates lesya-compile-to-olesya)
            (lesya:compile/->olesya:axiom axiom)
            (lesya:compile/->olesya:define define)
            (lesya:compile/->olesya:apply apply)
            (lesya:compile/->olesya:begin begin)
            (lesya:compile/->olesya:specify specify)
            (lesya:compile/->olesya:let let)
            (lesya:compile/->olesya:= =)
            (lesya:compile/->olesya:map map)
            (lesya:compile/->olesya:eval eval)
            )))


(define (wrapped-binding->wrapped-code name wrapped-binding)
  (define code name)
  (define interpretation
    (wrapped:interpretation wrapped-binding))
  (wrap code interpretation))


(define (bind! scope name evaluated)
  (define transformed
    (wrapped-binding->wrapped-code name evaluated))
  (lexical-scope-set! scope name transformed))



;;;;;;;;;;;;;;;;;;
;;
;; Instructions:
;;


(define-syntax lesya:compile/->olesya:axiom
  (syntax-rules ()
    ((_ term)
     (let ()
       (define q-term-0 (quote term))

       (define q-term
         (let loop ((q-term-0 q-term-0))
           (cond
            ((symbol? q-term-0) q-term-0)
            ((and (list? q-term-0)
                  (list-length= 2 q-term-0)
                  (equal? 'unquote (car q-term-0)))
             (wrapped:interpretation
              (local-eval (cadr q-term-0))))
            (else (map loop q-term-0)))))

       (define code
         (lesya-object->olesya-object q-term))
       (define interpretation
         code)

       (wrap code interpretation)))))


(define-syntax lesya:compile/->olesya:define
  (syntax-rules ()
    ((_ name expr)
     (begin
       (define scope
         (private:env))
       (define evaluated
         (local-eval (quote expr)))
       (define-values (code-rec interpretation-rec)
         (unwrap evaluated))
       (define code
         (olesya:syntax:define:make (quote name) code-rec))
       (define interpretation
         'impossible:return-values-of-define-should-not-be-used)
       (bind! scope (quote name) evaluated)
       (wrap code interpretation)))))


(define (lesya:compile/->olesya:apply:1-level
         e-rule e-argument)

  (define code
    (olesya:syntax:substitution:make
     (wrapped:code e-rule)
     (wrapped:code e-argument)))

  (define interpretation
    (olesya:interpret:with-error-possibility
     (olesya:interpret:map
      (wrapped:interpretation e-rule)
      (wrapped:interpretation e-argument))))

  (when (olesya:return:fail? interpretation)
    (raisu-fmt
     'failed-interpretation
     "This should not happen, but interpretation failed with ~s."
     interpretation))

  (wrap code interpretation))


(define (lesya:compile/->olesya:apply:quoted
         q-rule q-arguments)

  (define e-rule
    (local-eval q-rule))

  (let loop ((e-rule e-rule)
             (q-arguments q-arguments))

    (if (null? q-arguments) e-rule
        (let ()
          (define q-argument (car q-arguments))
          (define e-argument (local-eval q-argument))
          (define new-e-rule (lesya:compile/->olesya:apply:1-level e-rule e-argument))
          (loop new-e-rule (cdr q-arguments))))))


(define-syntax lesya:compile/->olesya:apply
  (syntax-rules ()
    ((_ rule . arguments)
     (lesya:compile/->olesya:apply:quoted
      (quote rule)
      (quote arguments)))))


(define is-empty-syntax?
  (let ()
    (define empty (olesya:syntax:begin:make))
    (lambda (object)
      (equal? empty object))))


(define-syntax lesya:compile/->olesya:begin/core
  (syntax-rules ()
    ((_ . bodies)
     (let ()
       (define body-code
         (quote bodies))
       (define bodies/wrapped
         (map local-eval body-code))
       (define interpretation
         (wrapped:interpretation (list-last bodies/wrapped)))
       (define codes
         (map wrapped:code bodies/wrapped))
       (values codes interpretation)))))


(define-syntax lesya:compile/->olesya:begin
  (syntax-rules ()
    ((_ . bodies)
     (let ()
       (define-values (codes interpretation)
         (lesya:compile/->olesya:begin/core . bodies))
       (define code
         (apply olesya:syntax:begin:make codes))
       (wrap code interpretation)))))


(define-syntax lesya:compile/->olesya:specify
  (syntax-rules ()
    ((_ varname subterm)
     (let ()
       (define code
         (olesya:syntax:rule:make
          (quasiquote varname) (quasiquote subterm)))
       (define interpretation
         code)
       (wrap code interpretation)))))


(define-syntax with-new-scope
  (syntax-rules ()
    ((_ . bodies)
     (let ()
       (define scope
         (private:env))
       (lexical-scope-stage! scope)
       (let ()
         (define result (let () . bodies))
         (lexical-scope-unstage! scope)
         result)))))


(define (lesya:compile/->olesya:let:bind! lets continuation)
  (let loop ((lets lets)
             (suppositions (list)))

    (if (null? lets)
        (continuation (reverse suppositions))

        (let ()
          (define first (car lets))
          (define-tuple (q-name q-shape) first)

          (define evaluated
            (local-eval (lesya:syntax:axiom:make q-shape)))
          (define-values (shape-code shape-interpretation)
            (unwrap evaluated))

          (with-new-scope
           (bind! (private:env) q-name evaluated)
           (loop
            (cdr lets)
            (cons (list q-name shape-code) suppositions)))))))


(define-syntax lesya:compile/->olesya:let
  (syntax-rules ()
    ((_ () . bodies)
     (with-new-scope
      (define-values (codes interpretation)
        (lesya:compile/->olesya:begin/core . bodies))
      (define supposition
        (list))
      (define code
        (apply olesya:syntax:let:make (cons supposition codes)))
      (wrap code interpretation)))

    ((_  lets . bodies)
     (lesya:compile/->olesya:let:bind!
      (quote lets)
      (lambda (suppositions)
        (define-values (codes interpretation-0)
          (lesya:compile/->olesya:begin/core . bodies))
        (define premises
          (map cadr suppositions))
        (define interpretation
          (list-fold/semigroup
           olesya:syntax:rule:make
           (append premises (list interpretation-0))))
        (define code
          (apply olesya:syntax:let:make (cons suppositions codes)))
        (wrap code interpretation))))))


(define-syntax lesya:compile/->olesya:=
  (syntax-rules ()
    ((_ a b)
     (let ()
       (define e-a (wrapped:interpretation (local-eval (quote a))))
       (define e-b (lesya-object->olesya-object (quote b)))
       (if (equal? e-a e-b)
           (wrap e-a e-a)
           (let ()
             (debugs
              (list 'context:
                    'actual: e-a
                    'expected: e-b
                    'endcontext:))

             (raisu-fmt
              'bad-interpretation
              "Terms are not equal: ~s vs ~s" e-a e-b)))))))


(define-syntax lesya:compile/->olesya:map
  (syntax-rules ()
    ((_ rule body)
     (let ()
       (define e-rule
         (local-eval (quote rule)))
       (define e-body
         (local-eval (quote body)))

       (define code
         (olesya:syntax:substitution:make
          (wrapped:code e-rule)
          (wrapped:code e-body)))

       (define interpretation
         (olesya:interpret:with-error-possibility
          (olesya:interpret:map
           (wrapped:interpretation e-rule)
           (wrapped:interpretation e-body))))

       (when (olesya:return:fail? interpretation)
         (raisu-fmt
          'failed-interpretation
          "This should not happen, but interpretation failed with ~s."
          interpretation))

       (wrap code interpretation)))))


(define-syntax lesya:compile/->olesya:eval
  (syntax-rules ()
    ((_ program)
     (let ()
       (define q-program (quote program))
       ;; (debugs q-program)
       (define x (local-eval q-program))
       ;; (debugs x)
       (define interp (wrapped:interpretation x))
       (define z (local-eval interp))
       ;; (debugs z)

       (define code
         (olesya:syntax:eval:make
          (wrapped:code z)))
       (define interpretation
         (wrapped:interpretation z))

       ;; (debugs code)

       (wrap code interpretation)))))
