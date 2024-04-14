;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; creates a Function on Pairs
(define-syntax fp
  (syntax-rules ()
    ((_ (arg1-name . arg*-name) . bodies)
     (lambda (lst-argument)
       (apply (lambda (arg1-name . arg*-name) . bodies) lst-argument)))))
