;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (catch-many types body handler)
  (define (nonexistant-key) #f)

  (guard
   (err1
    ((and (generic-error? err1)
          (let ()
            (define type (generic-error:value/unsafe err1 generic-error:type-key nonexistant-key))
            (member type types)))
     (handler err1)))
   (body)))
