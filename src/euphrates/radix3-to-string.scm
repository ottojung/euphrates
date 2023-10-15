;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (radix3->string r3)
  (define basevector (radix3:basevector r3))

  (define (radix-list->string lst)
    (apply
     string
     (map (lambda (c) (vector-ref basevector c)) lst)))

  (define sign (radix3:sign r3))
  (define prefix (if (> 0 sign) "-" ""))
  (define integral (radix-list->string (radix3:intpart r3)))
  (define fractional (radix-list->string (radix3:fracpart r3)))
  (define period (radix-list->string (radix3:period r3)))
  (define after-dot
    (string-append
     fractional
     (if (string-null? period) ""
         (string-append "(" period ")"))))

  (string-append
   prefix
   (if (string-null? after-dot) integral
       (string-append integral "." after-dot))))
