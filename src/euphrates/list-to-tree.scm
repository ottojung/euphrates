;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list->tree lst divider)
  (define (recur tag rest)
    (define droped '())
    (define taken
      (let lp ((lst rest))
        (if (null? lst)
            '()
            (let* ((x (car lst))
                   (xs (cdr lst)))
              (let-values
                  (((action d) (divider x xs)))
                (case action
                  ((open)
                   (let-values
                       (((sub right) (recur x xs)))
                     (cons (append d sub)
                           (lp right))))
                  ((close)
                   (set! droped xs)
                   d)
                  ((turn)
                   (lp d))
                  ((replace)
                   (cons d (lp xs)))
                  (else
                   (cons x (lp xs)))))))))

    (values taken droped))

  (let-values
      (((pre post) (recur 'root lst)))
    pre))

