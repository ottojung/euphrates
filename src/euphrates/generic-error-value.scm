;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax generic-error:value
  (syntax-rules ()
    ((_ err key default)
     (let ((err* err))
       (unless (generic-error? err*)
         (raisu 'type-error
                "Expected a generic error, but got something else"))

       (generic-error:value/unsafe err* key default)))))
