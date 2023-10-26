;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:optimize-to-bindings model bindings)
  (define bindings-found
    (list->hashset
     (map labelinglogic:binding:name bindings)))

  (define (is-binding? x)
    (hashset-has? bindings-found x))

  (define reachable-model
    (filter
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (is-binding? class))
     model))

  (define (bigloop model0)
    (define sugar-model
      (labelinglogic:model:map-expressions
       labelinglogic:expression:sugarify
       model0))

    (define combined-exprs-model
      (labelinglogic:model:map-expressions
       labelinglogic:expression:combine-recursively
       sugar-model))

    (define opt-model
      (labelinglogic:model:map-expressions
       labelinglogic:expression:optimize
       combined-exprs-model))

    (define referenced-model
      (labelinglogic:model:map-subexpressions
       (lambda (o-class o-predicate)
         (lambda (expr)
           (list-map-first
            (lambda (model-component)
              (define-tuple (b-class b-predicate) model-component)
              (and (not (equal? o-class b-class))
                   (is-binding? b-class)
                   (equal? expr b-predicate)
                   b-class))

            expr opt-model)))
       opt-model))

    referenced-model)

  (define opt-model
    (apply-until-fixpoint
     bigloop reachable-model))

  (define flat-model
    (labelinglogic:model:flatten opt-model))

  flat-model)
