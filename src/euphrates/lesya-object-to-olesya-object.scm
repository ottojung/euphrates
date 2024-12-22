;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (lesya-object->olesya-object object)
  (let loop ((object object))
    (if (lesya:syntax:implication? object)
        (let ()
          (define-values (premise consequence)
            (lesya:syntax:implication:destruct object 'impossible:must-be-implication))

          (olesya:syntax:rule:make
           (loop premise)
           (loop consequence)))

        (olesya:syntax:term:make object))))
