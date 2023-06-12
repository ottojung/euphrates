;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;
;; In this file we translate CFG-CLI definitions
;; into CFG-machine language.
;;
;; Example CFG-CLI body:
;;
;;   '(run OPTS* DATE <end-statement>
;;     OPTS* : --opts <opts...>*
;;           / --param1 <arg1>
;;           / --flag1
;;     DATE  : may <nth> MAY-OPTS?
;;           / june <nth> JUNE-OPTS*
;;     MAY-OPTS? : -p <x>
;;     JUNE-OPTS* : -f3 / -f4)
;;



(define (CFG-lang-modifier-char->CFG-function c)
  (case c
    ((#\*) '*)
    ((#\+) '+)
    ((#\?) '?)
    (else #f)))

(define (CFG-lang-modifier-char? c)
  (not (not (CFG-lang-modifier-char->CFG-function c))))

(define (CFG-AST->CFG-lang synonyms0)
  (define synonyms
    (map (lambda (x) (map ~a x)) synonyms0))

  (define (eqq value binding)
    (define get (assoc value synonyms))
    (define single (lambda (o) `(= ,o ,binding)))
    (if get
        (let ((all (cons value (cdr get))))
          `(or ,@(map single all)))
        (single value)))

  (define (placeholder-word? elem-string)
    (and (string-prefix? "<" elem-string)
         (string-suffix? ">" elem-string)))

  (define (multi-word? elem-string)
    (string-suffix? "..>" elem-string))

  (define (cons-transform c f)
    (compose f (lambda (x) (list (CFG-lang-modifier-char->CFG-function c) x))))

  (define (pimp-regex-element production-names elem)
    (define-values (stripped transform)
      (let loop ((elem-chars-r (reverse (string->list (~a elem))))
                 (transformations identity))
        (if (null? elem-chars-r) (raisu 'only-modifiers?)
            (let ((c (car elem-chars-r)))
              (if (CFG-lang-modifier-char? c)
                  (loop (cdr elem-chars-r)
                        (cons-transform c transformations))
                  (values (list->string (reverse elem-chars-r))
                          transformations))))))

    (define selem (~a elem))

    (define initial
      (cond
       ((hashset-has? production-names stripped)
        (list 'call (string->symbol stripped)))
       ((placeholder-word? stripped)
        (if (multi-word? stripped)
            (list 'any* selem)
            (list 'any selem)))
       (else ;; vv Constant vv
        (eqq stripped selem))))

    (transform initial))

  ;; Give regex elements additional structure.
  ;; So that this `(and --param1 <arg1>)`
  ;;      becomes `(and (= "--param1" "param1") (any "<arg1>"))`
  (define (pimp-regex production-names regex)
    (let loop ((regex regex))
      (if (pair? regex)
          ;; Don't touch functions.
          (cons (car regex) (map loop (cdr regex)))
          (pimp-regex-element production-names regex))))

  (lambda (AST)
    (define (andify regex)
      (cons 'and regex))
    (define (orify cases)
      (if (null? (cdr cases))
          (list (andify (car cases)))
          (list (cons 'or (map andify cases)))))
    (define anded-and-ored
      (map
       (lambda (production)
         (define name (car production))
         (define cases (cdr production))
         (cons name (orify cases)))
       AST))

    ;; Example anded-and-ored:
    ;;   '((MAIN   (and run OPTS* DATE <end-statement>))
    ;;     (OPTS*  (or (and --opts <opts...>*)
    ;;                 (and --param1 <arg1>)
    ;;                 (and --flag1)))
    ;;     (DATE   (or (and may  <nth> MAY-OPTS?)
    ;;                 (and june <nth> JUNE-OPTS*)))
    ;;     (MAY-OPTS?    (and -p <x>))
    ;;     (JUNE-OPTS*   (or (and -f3) (and -f4))))

    (define production-names ;; : listof string?
      (make-hashset (map (compose ~a car) anded-and-ored)))

    (define pimped
      (map
       (lambda (production)
         (define name (car production))
         (define regex (cadr production))
         (list name (pimp-regex production-names regex)))
       anded-and-ored))

    pimped))

(define (CFG-CLI->CFG-lang synonyms0)
  (define AST->lang (CFG-AST->CFG-lang synonyms0))
  (lambda (cli-body)
    (AST->lang (CFG-CLI->CFG-AST cli-body))))

