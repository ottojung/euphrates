;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic::model:check
         most-default-class model)
  (define (fail-model-check show args)
    (raisu* :from "labelinglogic::init"
            :type 'model-type-error
            :message (stringf "Type error in ~s: ~a." (quote model) show)
            :args args))

  (unless (list? model)
    (fail-model-check "must be a list" (list model)))

  (when (null? model)
    (fail-model-check "must be non-empty" (list model)))

  (define (check-if-r7rs-code x)
    (when (symbol? x)
      (unless (procedure? (eval x (environment '(scheme base) '(scheme char))))
        (fail-model-check
         "element predicate identified as R7RS code, but does not evaluate to a procedure"
         (list x))))

    #t)

  (for-each
   (lambda (model-component)
     (unless (list? model-component)
       (fail-model-check "element must be a list" (list model-component)))

     (define expected-length 2)

     (unless (list-length= expected-length model-component)
       (fail-model-check
        (stringf "element must have length = ~s" expected-length)
        (list model-component)))

     (define-tuple (class predicate) model-component)

     (unless (symbol? class)
       (fail-model-check "element class must be a symbol" (list class model-component)))

     (labelinglogic::expression::check predicate))

   model)

  (define classes/s
    (list->hashset (map car model)))

  (define class:predicate/h
    (let ((H (make-hashmap)))
      (for-each
       (lambda (model-component)
         (define-tuple (class predicate) model-component)
         (hashmap-set! H class predicate))
       model)
      H))

  (define recursion-hashset
    (make-hashset))

  (for-each
   (lambda (model-component)
     (define-tuple (class predicate) model-component)
     (define constants (labelinglogic::expression:constants predicate))
     (define undefined-constants
       (filter (negate (lambda (x) (hashset-has? classes/s x))) constants))

     (unless (null? undefined-constants)
       (fail-model-check
        "element predicate references undefined classes"
        (list class predicate undefined-constants))))

   model)

  )
