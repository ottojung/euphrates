;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define private:env
  (make-parameter #f))


(define (lesya:compile/->olesya program)
  (define wrapped
    (parameterize ((private:env (lexical-scope-make)))
      (lesya:compile/->olesya:eval program)))

  (wrapped:code wrapped))


(define (local-eval program)
  (if (symbol? program)
      (let ()
        (define default (make-unique))
        (define got (lexical-scope-ref (private:env) program default))
        (if (eq? got default)
            (raisu-fmt 'undefined-symbol "Undefined symbol ~s." (~a program))
            got))
      (eval program (lesya:compile/->olesya:environment))))


(define-type9 <wrapped>
  (wrap code interpretation) wrapped?
  (code wrapped:code)
  (interpretation wrapped:interpretation)
  )


(define (unwrap wrapped)
  (values
   (wrapped:code wrapped)
   (wrapped:interpretation wrapped)))


(define (lesya:compile/->olesya:environment)
  (environment
   '(only (scheme base) unquote)
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


;;;;;;;;;;;;;;;;;;
;;
;; Instructions:
;;


(define-syntax lesya:compile/->olesya:axiom
  (syntax-rules ()
    ((_ term)
     (let ()
       (define q-term (quote term))

       (define (transform q-term)
         (if (and
              (list? q-term)
              (equal? 3 (length q-term))
              (equal? 'if (car q-term))
              )

             (olesya:syntax:rule:make
              (transform (cadr q-term))
              (transform (caddr q-term)))

             (olesya:syntax:term:make q-term)))

       (define code
         (transform q-term))
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
       (lexical-scope-set! scope (quote name) evaluated)
       (wrap code interpretation)))))


(define-syntax lesya:compile/->olesya:apply
  (syntax-rules ()
    ((_ rule argument)
     (let ()
       (define code
         (olesya:syntax:substitution:make
          (quote rule) (quote argument)))

       (define rule-i
         (wrapped:interpretation (local-eval (quote rule))))
       (define argument-i
         (wrapped:interpretation (local-eval (quote argument))))

       (define interpretation
         (olesya:interpret:map rule-i argument-i))

       (wrap code interpretation)))

    ((_ rule argument . arguments)
     (syntax-error "Not implemented yet."))))


(define-syntax lesya:compile/->olesya:begin
  (syntax-rules ()
    ((_ arg)
     (local-eval (quote arg)))
    ((_ arg . args)
     (let ()
       (define-values (code-1 interpretation-1)
         (unwrap (local-eval (quote arg))))
       (define-values (code-rec interpretation)
         (unwrap (lesya:compile/->olesya:begin . args)))
       (define code
         (olesya:syntax:begin:make code-1 code-rec))
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


(define-syntax lesya:compile/->olesya:let
  (syntax-rules ()
    ((_ () . bodies)
     (let ()
       (define scope
         (private:env))
       (lexical-scope-stage! scope)
       (let ()
         (define body/quoted
           (quote bodies))
         (define body/wrapped
           (local-eval
            (apply olesya:syntax:begin:make body/quoted)))
         (define-values (body-code body-interpretation)
           (unwrap body/wrapped))
         (define supposition
           (list))
         (define body
           body-code)
         (define code
           (olesya:syntax:let:make supposition body))
         (define interpretation body-interpretation)
         (lexical-scope-unstage! scope)
         (wrap code interpretation))))

    ((_  ((name shape) . lets) . bodies)
     (let ()
       (define scope
         (private:env))
       (lexical-scope-stage! scope)
       (let ()
         (define q-shape (quote shape))
         (define evaluated
           (local-eval (lesya:syntax:axiom:make q-shape)))
         (define-values (shape-code shape-interpretation)
           (unwrap evaluated))
         (lexical-scope-set! scope (quote name) evaluated)
         (let ()
           (define recursive
             (lesya:compile/->olesya:let lets . bodies))
           (define-values (recursive-code recursive-interpretation)
             (unwrap recursive))
           (define supposition
             (list (list (quote name) shape-code)))
           (define body
             recursive-code)
           (define code
             (olesya:syntax:let:make supposition body))
           (define interpretation recursive-interpretation)
           (lexical-scope-unstage! scope)
           (wrap code interpretation)))))))


(define-syntax lesya:compile/->olesya:=
  (syntax-rules ()
    ((_ a b) a)))


(define-syntax lesya:compile/->olesya:map
  (syntax-rules ()
    ((_ rule body)
     (raisu 'TODO:7126378))))


(define (lesya:compile/->olesya:eval program)
  (local-eval program))
