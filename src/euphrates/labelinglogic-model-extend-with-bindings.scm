;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:extend-with-bindings model bindings)
  (define renamings
    (let ()
      (define H (make-hashmap))
      (for-each
       (lambda (model-component)
         (define-tuple (class predicate) model-component)
         (define type (labelinglogic:expression:type predicate))
         (define existing (hashmap-ref H predicate #f))

         (when existing
           (raisu* :from "labelinglogic:model:extend-with-bindings"
                   :type 'duplicated-token
                   :message (stringf "Two names ~s for the same expression ~s"
                                     (list existing class) (list predicate))
                   :args (list class predicate existing)))

         (when (equal? type 'constant)
           (hashmap-set! H predicate class)))
       bindings)
      H))

  (define replaced-model
    (labelinglogic:model:replace-constants
     (lambda (class)
       (lambda (constant)
         (define renamed
           (hashmap-ref renamings constant #f))
         (if (and renamed (not (equal? renamed class)))
             renamed
             constant ;; in the renaming thingy
             )))
     model))

  (define extended-model
    (append replaced-model bindings))

  extended-model)
