;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:check-references external-names/set model)
  (define names
    (labelinglogic:model:names model))

  (define duplicates
    (list-get-duplicates
     (filter
      (negate unique-identifier?)
      names)))

  (define names/set
    (list->hashset names))

  (unless (null? duplicates)
    (fail-tokens-check
     "names must not repeat"
     (list duplicates)))

  (for-each
   (lambda (binding)
     (define expr (labelinglogic:binding:expr binding))
     (define constants (labelinglogic:expression:constants expr))

     (define undefined-constants
       (filter (negate
                (lambda (x)
                  (or (hashset-has? external-names/set x)
                      (hashset-has? names/set x))))
               constants))

     (unless (null? undefined-constants)
       (raisu* :from "labelinglogic"
               :type 'undefined-reference-in-binding
               :message "Binding references undefined class."
               :args (list expr binding undefined-constants)))

     )

   (labelinglogic:model:bindings model))

  (when #f #t))
