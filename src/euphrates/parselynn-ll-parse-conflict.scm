;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 <first/first-conflict>
  (parselynn:ll-parse-first-first-conflict:constructor
   candidate productions)

  parselynn:ll-parse-first-first-conflict?

  (candidate parselynn:ll-parse-first-first-conflict:candidate)
  (productions parselynn:ll-parse-first-first-conflict:productions)
  )


(define (parselynn:ll-parse-first-first-conflict:make candidate productions)
  (unless (list? productions)
     (raisu* :from "parselynn:ll-parse-first-first-conflict:make"
             :type 'expected-a-list
             :message (stringf "Expected a list of productions, got ~s."
                               productions)
             :args (list productions)))

  (when (null? productions)
     (raisu* :from "parselynn:ll-parse-first-first-conflict:make"
             :type 'expected-a-nonempty-list
             :message "Expected a nonempty list of productions, got ()."
             :args (list)))

  (unless (list-and-map bnf-alist:production? productions)
     (raisu* :from "parselynn:ll-parse-first-first-conflict:make"
             :type 'expected-a-list-of-productions
             :message (stringf "Expected a list of productions, got ~s."
                               productions)
             :args (list productions)))

  (unless (bnf-alist:leaf? candidate)
     (raisu* :from "parselynn:ll-parse-first-first-conflict:make"
             :type 'expected-a-leaf
             :message (stringf "Expected a leaf for candidate, got ~s."
                               candidate)
             :args (list candidate)))

  (parselynn:ll-parse-first-first-conflict:constructor
   candidate productions))


(define (parselynn:ll-parse-first-first-conflict:nonterminal conflict)
  (define productions
    (parselynn:ll-parse-first-first-conflict:productions conflict))
  (bnf-alist:production:lhs (car productions)))


(define-type9 <recursion-conflict>
  (parselynn:ll-parse-recursion-conflict:make
   nonterminal cycle)

  parselynn:ll-parse-recursion-conflict?

  (nonterminal parselynn:ll-parse-recursion-conflict:nonterminal)
  (cycle parselynn:ll-parse-recursion-conflict:cycle)
  )


(define (parselynn:ll-parse-conflict? object)
  (or (parselynn:ll-parse-first-first-conflict? object)
      (parselynn:ll-parse-recursion-conflict? object)))
