;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax assert-buf
  (syntax-rules ()
    ((_ orig buf head (last-r))
     (let ((last last-r))
       (unless (reversed-args-f head last . buf)
         (raisu 'assertion-fail
                `(test: ,(cons (quote head) (reversed-args-f list last . buf)))
                `(original: ,(quote orig))))))
    ((_ orig buf head (last-r) . printf-args)
     (let ((last last-r))
       (unless (reversed-args-f head last . buf)
         (raisu 'assertion-fail
                `(test: ,(cons (quote head) (reversed-args-f list last . buf)))
                `(original: ,(quote orig))
                `(description: ,(stringf . printf-args))))))
    ((_ orig buf head (x-r . xs-r) . printf-args)
     (let ((x x-r))
       (assert-buf orig (x . buf) head xs-r . printf-args)))))

;; reduces test to normal form by hand
(define-syntax assert
  (syntax-rules ()
    ((_ (x . xs) . printf-args)
     (assert-buf (x . xs) () x xs . printf-args))
    ((_ test . printf-args)
     (assert/raw test . printf-args))))
