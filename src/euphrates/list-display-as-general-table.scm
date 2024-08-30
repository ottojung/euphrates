;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list:display-as-general-table:check-type lst)
  (when (null? lst)
    (raisu* :from "list:display-as-general-table"
            :type 'type-error
            :message "Expected non-empty list."
            :args (list lst)))

  (unless (list? lst)
    (raisu* :from "list:display-as-general-table"
            :type 'type-error
            :message "Expected a list."
            :args (list lst)))

  (let ()
    (define len
      (length (car lst)))

    (for-each

     (lambda (row)
       (unless (list? row)
         (raisu* :from "list:display-as-general-table"
                 :type 'type-error
                 :message "Expected list of lists."
                 :args (list row lst)))

       (unless (= len (length row))
         (raisu* :from "list:display-as-general-table"
                 :type 'type-error
                 :message "Expected a rectangular list of lists."
                 :args (list row lst))))

     lst)))

(define list:display-as-general-table
  (case-lambda
   ((lst)
    (list:display-as-general-table lst (current-output-port)))

   ((lst port)
    (define _1 (list:display-as-general-table:check-type lst))

    (define (compute-max-length column-index)
      (list-maximal-element-or
       0 >
       (map
        (lambda (elem)
          (string-length (~a (list-ref elem column-index))))
        lst)))

    (define first-row
      (car lst))

    (define n-columns
      (length first-row))

    (define max-lengths
      (map compute-max-length
           (iota n-columns)))

    (define divider
      (apply
       string
       (append
        (list #\+ #\space)
        (replicate
         (+ 1 -4
            (list-fold/semigroup
             + (map (lambda (n) (+ 3 n)) max-lengths)))
         #\-)
        (list #\space #\+)
        )))

    (define (startline)
      (display divider port)
      (newline port))

    (define (display-column row column-index)
      (define elem (list-ref row column-index))
      (define str (~a elem))
      (define size (list-ref max-lengths column-index))
      (define padded (string-pad-L str size #\space))

      (display #\! port)
      (display #\space port)
      (display padded port)
      (display #\space port))

    (define (display-row row)
      (startline)

      (for-each
       (comp (display-column row))
       (iota n-columns))

      (display #\! port)
      (newline port))

    (for-each display-row lst)
    (startline)

    (values))))
