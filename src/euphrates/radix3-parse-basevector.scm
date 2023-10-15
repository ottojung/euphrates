;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define radix3:parse-basevector
  (let ()
    (define basevector/max/default alphanum-lowercase/alphabet)
    (define numbase/max (vector-length basevector/max/default))
    (define default-basevectors (make-vector numbase/max #f))
    (define (get-default-basevector size)
      (define existing (vector-ref default-basevectors size))
      (or existing
          (let ()
            (define new (vector-copy basevector/max/default 0 size))
            (vector-set! default-basevectors size new)
            new)))

    (lambda (base)

      (cond
       ((vector? base) base)
       ((number? base)
        (cond
         ((or (> 2 base) (< numbase/max base))
          (raisu* :from "radix3:parse-basevector"
                  :type 'type-error
                  :message
                  (stringf
                   "If base is a number, then it must be in the [2, ~s] range"
                   numbase/max)
                  :args (list base numbase/max)))

         ((or (not (integer? base)) (inexact? base))
          (raisu* :from "radix3:parse-basevector"
                  :type 'type-error
                  :message "If base is a number, then it must be a whole exact integer"
                  :args (list base)))

         (else (get-default-basevector base))))

       (else
        (raisu* :from "radix3:parse-basevector"
                :type 'type-error
                :message "Base expected to be a number or a vector"
                :args (list base)))))))
