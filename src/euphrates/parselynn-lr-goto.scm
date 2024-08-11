;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; This procedure computes the GOTO function for LR(1) items.
;; Given a state (set of LR(1) items) and a grammar symbol (terminal or non-terminal),
;; it computes the new set of LR(1) items (the GOTO state) that results from reading
;; that symbol from the given state.
;;
;; The GOTO function transitions the parser from one state to another by shifting the dot (•)
;; over a grammar symbol. Formally, if I is a set of items and X is a grammar symbol,
;; GOTO(I, X) is the closure of the set of items obtained by shifting the dot
;; in each item of I over X.
;;

(define (parselynn:lr-goto state symbol bnf-alist)
  ;; Create a new state that will collect the result.
  (define next-state
    (parselynn:lr-state:make))

  ;; Go through each item in the current state.
  (hashset-foreach
   (lambda (item)
     (when (and (not (parselynn:lr-item:dot-at-end? item))
                (equal? (parselynn:lr-item:next-symbol item) symbol))
       (let ()
         ;; Shift the dot over the symbol.
         (define advanced-item
           (parselynn:lr-item:advance item))
         ;; Compute the closure of the advanced item.
         (define closure
           (parselynn:lr-closure bnf-alist advanced-item))
         ;; Add every item in the closure to the next state.
         (hashset-foreach
          (lambda (closure-item)
            (parselynn:lr-state:add! next-state closure-item))
          (parselynn:lr-state:set closure)))))
   (parselynn:lr-state:set state))

  ;; Return the new GOTO state.
  next-state)
