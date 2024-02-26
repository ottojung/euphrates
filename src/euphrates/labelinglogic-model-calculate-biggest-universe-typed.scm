;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:calculate-biggest-universe/typed
         model expression)

  (let dloop ((expression expression))
    ;; (define expression/d
    ;;   (labelinglogic:expression:desugar expression))

    (define expression/d expression)

    (let loop ((expression expression/d))

      (define type (labelinglogic:expression:type expression))
      (define args (labelinglogic:expression:args expression))

      (cond

       ((member type (list '= 'r7rs))
        (list expression))

       ((equal? type 'constant)
        (let ()
          (define target (assoc (car args) model))
          (unless target
            (raisu* :from "labelinglogic:model:calculate-biggest-universe"
                    :type 'undefined-reference
                    :message "Pointer to undefined model-component"
                    :args (list expression)))

          (define-tuple (class predicate) target)

          (dloop predicate)))

       ((equal? type 'or)
        (list-deduplicate
         (apply
          append
          (map loop args))))

       ((equal? type 'and)
        (list-fold/semigroup
         list-intersect
         (map loop args)))

       ((equal? type 'tuple)
        (let ()
          (define rec (map loop args))
          (define rev (reverse rec))
          (define revp
            (cons (map list (car rev))
                  (cdr rev)))
          (define revrevp (reverse revp))

          (define collected
            (list-fold/right/semigroup
             cartesian-product
             revrevp))

          (map labelinglogic:citizen:tuple:make collected)))

       (else
        (raisu* :from "labelinglogic:model:calculate-biggest-universe/typed"
                :type 'unknown-expr-type
                :message (stringf "Expression type ~s not recognized"
                                  (~a type))
                :args (list type expression)))))))
