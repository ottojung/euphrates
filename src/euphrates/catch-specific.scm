;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (nonexistant-key) 'dummy-key)

(define (catch-specific key body handler)
  (guard
   (err1
    ((and (generic-error? err1)
          (equal? key (generic-error:value/unsafe err1 generic-error:type-key nonexistant-key)))
     (handler err1)))
   (body)))
