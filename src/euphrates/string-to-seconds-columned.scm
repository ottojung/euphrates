;;;; Copyright (C) 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;; accepts format like "2:30" or "30:2" or "2:20:3" or "2:20:3.22"


(define (string->seconds/columned s)
  (define L (string-split/simple s #\:))
  (define len (length L))
  (define _124124
    (when (> len 4)
      (raisu 'bad-format:expected-4-components-but-got len)))
  (define nums (map string->number L))
  (define filled-out
    (append
     (map (const 0)
          (range (- 4 len)))
     nums))

  (let loop ((filled-out filled-out))
    (unless (null? filled-out)
      (unless (number? (car filled-out))
        (raisu 'bad-format:expected-all-numbers))
      (loop (cdr filled-out))))

  (+ (* (list-ref filled-out 0) 24 60 60)
     (* (list-ref filled-out 1) 60 60)
     (* (list-ref filled-out 2) 60)
     (* (list-ref filled-out 3) 1)))
