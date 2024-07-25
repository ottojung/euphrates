;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (bnf-alist:terminals bnf)
  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals bnf)))

  (define terminals
    (stack-make))

  (define (add-terminal! token)
    (unless (hashset-has? nonterminals token)
      (stack-push! terminals token)))

  (define (iter nonterminal)
    (lambda (production)
      (for-each add-terminal! production)))

  (bnf-alist:for-each-production iter bnf)

  (reverse
   (stack->list terminals)))
