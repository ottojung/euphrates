;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Define the type <parselynn:lr-item>, which represents an LR(1) item in a grammar.
;; An LR(1) item consists of a non-terminal (left-hand-side), a dot position,
;; a right-hand-side list of symbols (the production), and a lookahead symbol.
;;

(define-type9 <parselynn:lr-item>
  (parselynn:lr-item:constructor
   left-hand-side   ;; A non-terminal symbol.
   dot-position     ;; A natural number indicating the position of the dot.
   right-hand-side  ;; A list of terminals and non-terminals representing the production.
   lookahead        ;; A terminal or end-of-input symbol.
   )

  parselynn:lr-item?

  ;; Fields of the LR(1) item
  (left-hand-side parselynn:lr-item:left-hand-side)
  (dot-position parselynn:lr-item:dot-position)
  (right-hand-side parselynn:lr-item:right-hand-side)
  (lookahead parselynn:lr-item:lookahead)
  )

;;
;; Create a new LR(1) item. The dot position starts at 0.
;;
(define (parselynn:lr-item:make lhs rhs lookahead)
  (define dot-pos 0)
  (parselynn:lr-item:constructor
   lhs
   dot-pos
   rhs
   lookahead))

;;
;; Check if the dot (•) is at the end of the right-hand-side of the LR(1) item.
;;
(define (parselynn:lr-item:dot-at-end? item)
  (define dot-pos (parselynn:lr-item:dot-position item))
  (define rhs (parselynn:lr-item:right-hand-side item))
  (define len (length rhs))
  (>= dot-pos len))

;;
;; Get the symbol immediately after the dot (•) in the LR(1) item.
;; Raises an eror if the dot is at the end.
;;
(define (parselynn:lr-item:next-symbol item)
  (define dot-pos (parselynn:lr-item:dot-position item))
  (define rhs (parselynn:lr-item:right-hand-side item))
  (define len (length rhs))

  (if (parselynn:lr-item:dot-at-end? item)
      (raisu* :from "parselynn:lr-item"
              :type 'cannot-peek-past-end
              :message "Cannot peek a symbol of LR item past its RHS length."
              :args (list item))
      (list-ref rhs dot-pos)))

;;
;; Advance the dot (•) in the LR(1) item.
;; If the dot is already at the end, raises an error.
;;
(define (parselynn:lr-item:advance item)
  (define lhs (parselynn:lr-item:left-hand-side item))
  (define dot-pos (parselynn:lr-item:dot-position item))
  (define rhs (parselynn:lr-item:right-hand-side item))
  (define lookahead (parselynn:lr-item:lookahead item))
  (if (parselynn:lr-item:dot-at-end? item)
      (raisu* :from "parselynn:lr-item"
              :type 'cannot-advance-past-end
              :message "Cannot advance an LR item past its RHS length."
              :args (list item))
      (parselynn:lr-item:constructor lhs (+ 1 dot-pos) rhs lookahead)))

;;
;; Get the symbols before the dot (•) in the LR(1) item.
;;
(define (parselynn:lr-item:before-dot item)
  (define dot-pos (parselynn:lr-item:dot-position item))
  (define rhs (parselynn:lr-item:right-hand-side item))
  (list-take-n dot-pos rhs))

;;
;; Get the symbols after the dot (•) in the LR(1) item.
;;
(define (parselynn:lr-item:after-dot item)
  (define dot-pos (parselynn:lr-item:dot-position item))
  (define rhs (parselynn:lr-item:right-hand-side item))
  (list-drop-n dot-pos rhs))

;;
;; Print the LR(1) item in a human-readable format.
;;
(define parselynn:lr-item:print
  (case-lambda
   ((item)
    (parselynn:lr-item:print item (current-output-port)))

   ((item port)
    (define before-dot
      (parselynn:lr-item:before-dot item))
    (define after-dot
      (parselynn:lr-item:after-dot item))
    (define lhs
      (parselynn:lr-item:left-hand-side item))
    (define lookahead
      (parselynn:lr-item:lookahead item))
    (define (print-symbol X)
      (display " ")
      (if (equal? X parselynn:epsilon)
          (display "ε")
          (display (object->string X))))

    (parameterize ((current-output-port port))
      (display "[")
      (display (object->string lhs))
      (display " →")
      (for-each print-symbol before-dot)
      (display " •")
      (for-each print-symbol after-dot)
      (display ",")
      (print-symbol lookahead)
      (display "]")))))
