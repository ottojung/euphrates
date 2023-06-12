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


;; Like shell-quote but more permissive


(define (shell-special-word? str)
  (cond
   ((equal? "~" str) #t)
   ((equal? "*" str) #t)
   ((equal? "[" str) #t)
   ((equal? "]" str) #t)
   ((equal? "{" str) #t)
   ((equal? "}" str) #t)
   ((equal? "?" str) #t)
   ((equal? "!" str) #t)
   ((equal? ";" str) #t)
   ((equal? "|" str) #t)
   ((equal? "||" str) #t)
   ((equal? "&" str) #t)
   ((equal? "&&" str) #t)
   ((equal? ">" str) #t)
   ((equal? ">>" str) #t)
   ((equal? ">>>" str) #t)
   ((equal? "<" str) #t)
   ((equal? "<<" str) #t)
   ((equal? "<<<" str) #t)
   ((equal? "1>&2" str) #t)
   ((equal? "2>&1" str) #t)
   ((equal? "0>&2" str) #t)
   ((equal? "2>&0" str) #t)
   ((equal? "0>&1" str) #t)
   ((equal? "1>&0" str) #t)
   (else #f)))

(define (shell-quote/permissive str)
  (define lst (string->list str))
  (cond
   ((shell-special-word? str) str)
   ((null? (filter (negate shell-nondisrupt/alphabet/index) lst)) str)
   (else (shell-quote/always/list lst))))
