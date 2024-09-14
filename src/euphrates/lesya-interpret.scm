;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define lesya:environment
  (environment
   '(rename (euphrates lesya-language)
            (lesya:language:when when)
            (lesya:language:cons cons)
            (lesya:language:begin begin)
            )))

(define (lesya:interpret program)
  (lesya:language:run
   (eval program lesya:environment)))
