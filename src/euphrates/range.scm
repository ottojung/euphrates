;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define range
  (case-lambda
   ((start count)
    (if (> count 0)
        (cons start (range (+ 1 start) (- count 1)))
        '()))
   ((count)
    (range 0 count))))
