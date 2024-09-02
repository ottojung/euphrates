;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define iterator->list
  (let ()
    (define stop-symbol
      (make-unique))

    (lambda (iterator)
      (let loop ()
        (define x (iterator:next iterator stop-symbol))
        (if (eq? x stop-symbol)
            '()
            (cons x (loop)))))))
