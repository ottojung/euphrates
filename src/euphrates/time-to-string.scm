;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (seconds->M/s seconds0)
  (define seconds (remainder seconds0 60))
  (define minutes0 (quotient seconds0 60))
  (values minutes0 seconds))

(define (seconds->H/M/s seconds0)
  (define-values (minutes0 seconds)
    (seconds->M/s seconds0))
  (define minutes (remainder minutes0 60))
  (define hours0 (quotient minutes0 60))
  (values hours0 minutes seconds))

(define (seconds->time-string seconds0)
  (define-values (hours minutes seconds)
    (seconds->H/M/s seconds0))

  (string-append
   (number->string hours) ":"
   (string-pad-L (number->string minutes) 2 #\0) ":"
   (string-pad-L (number->string seconds) 2 #\0)))

;; TODO: other conversions
