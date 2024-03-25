;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:latticize-ands-assuming-nointersect-dnf model)

  (define (nicolaus? x)
    (and (labelinglogic:expression? x)
         (let ()
           (define type (labelinglogic:expression:type x))
           (define args (labelinglogic:expression:args x))

           (or (equal? 'r7rs type)
               (and (equal? 'and type)
                    (list-or-map nicolaus? args))))))

  (define nicolaus-map (make-hashmap))

  (define _1237123
    (for-each
     (lambda (binding)
       (define class (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))

       (define terms
         (if (equal? 'or type) args (list expr)))

       (define r7rss
         (filter
          (lambda (term)
            (define type (labelinglogic:expression:type term))
            (define args (labelinglogic:expression:args term))

            (or (equal? 'r7rs type)
                (and (equal? 'and type)
                     (list-or-map
                      (lambda (arg)
                        (define type (labelinglogic:expression:type arg))
                        (define args (labelinglogic:expression:args arg))
                        (equal? type 'r7rs))
                      args))))
          terms))

       0)
     (labelinglogic:model:bindings model)))

  model)
