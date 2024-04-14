;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define fn-cons
  (case-lambda
   ((fn-car fn-cdr)
    (lambda (lst)
      (cons (fn-car (car lst)) (fn-cdr (cdr lst)))))
   ((fn-car fn-cadr . fns)
    (lambda (lst)
      (cons (fn-car (car lst))
            (cons (fn-cadr (cadr lst))
                  (let loop ((lst (cddr lst)) (fns fns))
                    (if (null? fns) lst
                        (if (null? (cdr fns))
                            ((car fns) lst)
                            (cons ((car fns) (car lst))
                                  (loop (cdr lst) (cdr fns))))))))))))
