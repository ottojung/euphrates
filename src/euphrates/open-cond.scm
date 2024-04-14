;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define open-cond? open-cond-predicate)

(define-syntax define-open-cond
  (syntax-rules ()
    ((_ name)
     (define name (open-cond-constructor '())))))

(define-syntax define-open-cond-instance
  (syntax-rules ()
    ((_ open-cond function)
     (set-open-cond-value!
      open-cond
      (cons function (open-cond-value open-cond))))))

(define-syntax open-cond-lambda
  (syntax-rules ()
    ((_ open-cond default)
     (lambda args
       (let ((buf (open-cond-value open-cond)))
         (let loop ((buf buf))
           (if (null? buf) (apply default args)
               (let ((R (apply (car buf) args)))
                 (or R (loop (cdr buf)))))))))
    ((_ open-cond)
     (lambda args
       (let ((buf (open-cond-value open-cond)))
         (let loop ((buf buf))
           (and (not (null? buf))
                (let ((R (apply (car buf) args)))
                  (or R (loop (cdr buf)))))))))))
