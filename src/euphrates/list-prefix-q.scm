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

(cond-expand
 (guile
  (define-module (euphrates list-prefix-q)
    :export (list-prefix?))))


(define (list-prefix? prefix-lst target-lst)
  (let loop ((prefix-lst prefix-lst)
             (target-lst target-lst))
    (cond
     ((null? prefix-lst) #t)
     ((null? target-lst) #f)
     (else
      (and (equal? (car prefix-lst) (car target-lst))
           (loop (cdr prefix-lst) (cdr target-lst)))))))
