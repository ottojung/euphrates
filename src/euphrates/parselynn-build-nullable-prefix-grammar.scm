;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Helper: determine if SYMBOL is nullable.
(define (parselynn:nullable? symbol first-set bnf-alist)
  (define set (hashmap-ref first-set symbol #f))
  (and set (hashset-has? set parselynn:epsilon)))


;;; Given a production RHS (a list of symbols),
;;; return its nullable prefix (i.e. as long as symbols are nonterminals
;;; and nullable), discarding the first nonnullable symbol.
(define (parselynn:take-nullable-prefix first-set bnf-alist rhs)
  (list-take-until
   (lambda (sym)
     ;; We continue taking while sym is nullable.
     ;; This includes the first non-nullable symbol, if it exists.
     (not (parselynn:nullable? sym first-set bnf-alist)))
   rhs))


;;; Build the dependency mapping from a BNF grammar.
;;; The bnf-alist is assumed to be a list where each element is a pair (NT productions)
;;; with productions a list of production-rhs lists.
;;; For each nonterminal (the LHS) we gather, from each production,
;;; the symbols in the nullable prefix. The resulting graph is a hashmap
;;; mapping LHS to the union (list) of such symbols.
(define (parselynn:build-nullable-prefix-grammar bnf-alist)
  (define first-set (bnf-alist:compute-first-set bnf-alist))
  (define ret-stack (stack-make))
  (define take-prefix
    (comp
     (parselynn:take-nullable-prefix first-set bnf-alist)))

  (define (handle-production lhs)
    (define deps (stack-make))
    (stack-push! ret-stack (cons lhs deps))

    (lambda (rhs)
      (define rhs-deps (stack-make))
      (define (add-dep dep)
        (stack-push! rhs-deps dep))

      (define prefix (take-prefix rhs))
      (stack-push! deps rhs-deps)
      (for-each add-dep prefix)))

  (bnf-alist:for-each-production handle-production bnf-alist)

  (map
   (fn-cons
    identity
    (comp stack->list reverse
          (map (comp stack->list reverse))))
   (reverse
    (stack->list ret-stack))))
