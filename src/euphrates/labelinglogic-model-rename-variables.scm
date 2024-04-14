;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:rename-variables renamer-fun model)
  (define memory (make-hashmap))
  (define default-key (make-unique))

  (define (cached-renamer variable)
    (define existing
      (hashmap-ref memory variable default-key))

    (if (equal? existing default-key)
        (let ()
          (define new (renamer-fun variable))
          (labelinglogic:expression:check new)
          (let ()
            (define type (labelinglogic:expression:type new))
            (unless (equal? 'variable type)
              (raisu* :from "labelinglogic:expression:rename"
                      :type 'rename-type-error
                      :message (stringf "Can only rename to variables, but got ~s" (~a type))
                      :args (list type new variable))))

          (hashmap-set! memory variable new)
          new)
        existing))

  (for-each
   cached-renamer
   (labelinglogic:model:names model))

  (map
   (lambda (model-component)
     (define-tuple (class predicate) model-component)
     (list (cached-renamer class)
           (labelinglogic:expression:replace-variables
            cached-renamer predicate)))
   model))
