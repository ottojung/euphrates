;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <parse-conflict>
  (parselynn:lr-parse-conflict:constructor
   state
   symbol
   actions-stack
   )

  parselynn:lr-parse-conflict?

  (state parselynn:lr-parse-conflict:state)
  (symbol parselynn:lr-parse-conflict:symbol)
  (actions-stack parselynn:lr-parse-conflict:actions-stack)
  )


(define (parselynn:lr-parse-conflict:make
         state symbol action1 action2)
  (define actions-stack (stack-make))
  (stack-push! actions-stack action1)
  (stack-push! actions-stack action2)

  (when (equal? action1 action2)
    (raisu* :from "parselynn:lr-parse-conflict"
            :type 'actions-must-be-distinct
            :message "Actions in parse conflict must be not equal to each other."
            :args (list action1 action2)))

  (parselynn:lr-parse-conflict:constructor
   state symbol actions-stack))


(define (parselynn:lr-parse-conflict:add! conflict action)
  (define actions-stack
    (parselynn:lr-parse-conflict:actions-stack conflict))
  (unless (member action (stack->list actions-stack))
    (stack-push! actions-stack action)))


(define (parselynn:lr-parse-conflict:actions conflict)
  (define actions-stack
    (parselynn:lr-parse-conflict:actions-stack conflict))
  (stack->list actions-stack))
