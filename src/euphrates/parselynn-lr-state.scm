;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Define the type <parselynn:lr-state>, which represents a set of LR(1) items.
;;

(define-type9 <parselynn:lr-state>
  (parselynn:lr-state:constructor
   set)    ;; Set of LR items.

  parselynn:lr-state?

  ;; Field of the LR state
  (set parselynn:lr-state:set))

;;
;; Create a new, empty LR state.
;;
(define (parselynn:lr-state:make)
  (define set (make-hashset))
  (parselynn:lr-state:constructor set))

;;
;; Add an LR(1) item to the LR state.
;;
(define (parselynn:lr-state:add! state item)
  (define set (parselynn:lr-state:set state))
  (hashset-add! set item))

;;
;; Check if an LR(1) item is present in the LR state.
;;
(define (parselynn:lr-state:has? state item)
  (define set (parselynn:lr-state:set state))
  (hashset-has? set item))

;;
;; Print the LR state in a human-readable format.
;;
(define parselynn:lr-state:print
  (case-lambda
   ((state)
    (parselynn:lr-state:print state (current-output-port)))

   ((state port)
    (define (print-item item)
      (parselynn:lr-item:print item))

    (define unsorted-items
      (hashset->list
       (parselynn:lr-state:set state)))

    (define stringified-items
      (map
       (lambda (item)
         (with-output-stringified
          (print-item item)))
       unsorted-items))

    (define items
      (euphrates:list-sort
       stringified-items
       string<?))

    (parameterize ((current-output-port port))
      (display "{ ")
      (display (words->string items))
      (display " }")))))

;;
;; Compare two LR states for equality.
;; Two LR states are equal if they contain the same set of LR(1) items.
;;
(define (parselynn:lr-state:equal? state1 state2)
  (equal?
   (with-output-stringified
    (parselynn:lr-state:print state1))
   (with-output-stringified
    (parselynn:lr-state:print state2))))

;;
;; Iterates through each item in the state.
;;
(define (parselynn:lr-state:foreach-item fn state)
  (hashset-foreach
   fn (parselynn:lr-state:set state)))
