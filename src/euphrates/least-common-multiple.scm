;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (least-common-multiple a b)
  ;; If either number is 0, the LCM is 0
  (if (or (= a 0) (= b 0)) 0
      ;; else LCM = (|a * b| / GCD)
      (/ (abs (* a b))
         (greatest-common-divisor a b))))
