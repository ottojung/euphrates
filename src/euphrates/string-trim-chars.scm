;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (string-trim-chars str chars-arg direction)
  (define chars (if (string? chars-arg)
                    (string->list chars-arg)
                    chars-arg))
  (define (pred c)
    (memv c chars))
  (case direction
    ((left) (string-trim str pred))
    ((right) (string-trim-right str pred))
    ((both) (string-trim-both str pred))))
