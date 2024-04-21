;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:folexer:expression:head? expr)
  (cond
   ((string? expr) #t)
   ((char? expr) #t)

   ((and (pair? expr) (list? expr))
    (let ()
      (define type (car expr))
      (cond

       ((member type (list 'or 'and 'not))
        #t)

       ((member type (list 'constant 'r7rs))
        #t)

       ((member type (list 'class))
        #t)

       (else #f))))

   (else #f)))
