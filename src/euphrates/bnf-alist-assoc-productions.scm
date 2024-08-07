;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax bnf-alist:assoc-productions
  (syntax-rules ()
    ((_ nonterminal bnf-alist default)
     (assoc-or
      nonterminal
      bnf-alist
      default))

    ((_ nonterminal bnf-alist)
     (let ()
       (define nonterminal* nonterminal)
       (define bnf-alist* bnf-alist)
       (assoc-or
        nonterminal*
        bnf-alist*
        (raisu* :from "bnf-alist:assoc-productions"
                :type 'nonterminal-not-found
                :message "Nonterminal not found in BNF alist."
                :args (list nonterminal* bnf-alist*)))))))
