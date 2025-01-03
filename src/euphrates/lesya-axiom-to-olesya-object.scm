;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lesya-axiom->olesya-object on-unquote object)
  (olesya:syntax:term:make
   (let loop ((object object))
     (cond
      ((and (list? object)
            (list-length= 2 object)
            (equal? 'unquote (car object)))
       (on-unquote object))

      ((and (pair? object) (list? object))
       (cons (car object) (map loop (cdr object))))

      (else object)))))
