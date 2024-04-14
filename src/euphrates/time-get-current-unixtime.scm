;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;; Calculates current unixtime UTC
;;
;; @returns Fraction, where integer part is seconds


(define (time-get-current-unixtime/values)
  ((or (time-get-current-unixtime/values/p)
       time-get-current-unixtime/values/p-default)))

(define (time-get-current-unixtime)
  (define-values (second nanosecond) (time-get-current-unixtime/values))
  (exact->inexact
   (+ second (nano->normal/unit nanosecond))))
