;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list->iterator lst)
  (define rest lst)
  (define (generator)
    (if (null? rest)
        (values #t #t)
        (let ()
          (define ret (car rest))
          (set! rest (cdr rest))
          (values ret #f))))

  (iterator:make generator #f))
