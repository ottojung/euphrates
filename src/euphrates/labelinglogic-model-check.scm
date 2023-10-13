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

     (unless (or (equal? 'union predicate)
                 (and (list? predicate)
                      (list-length= 2 predicate)
                      (equal? (car predicate) 'r7rs)
                      (check-if-r7rs-code predicate)))
       (fail-model-check (stringf "element predicate must be the symbol ~s or R7RS code like '(r7rs (lambda (x) (= x 1)))." (list (~a 'union)))
                         (list predicate model-component)))

     (unless (or (equal? most-default-class superclass) (symbol? superclass))
       (fail-model-check "element superclass must be a symbol" (list superclass model-component))))

   model)

  (define falses
    (filter
     (lambda (model-component)
       (define-tuple (class predicate superclass) model-component)
       (equal? class most-default-class))
     model))

  (unless (or (null? falses)
              (list-singleton? falses))
    (fail-model-check "only one class can have most-default-class as its superclass" (list falses)))

  (define classes/s
    (list->hashset (map car model)))

  (define class:predicate/h
    (let ((H (make-hashmap)))
      (for-each
       (lambda (model-component)
         (define-tuple (class predicate superclass) model-component)
         (hashmap-set! H class predicate))
       model)
      H))

  (define default-key
    (make-unique))

  (for-each
   (lambda (model-component)
     (define-tuple (class predicate superclass) model-component)
     (define super-predicate
       (hashmap-ref class:predicate/h superclass default-key))

     (cond

      ((equal? most-default-class class)
       (unless (equal? most-default-class superclass)
         (fail-model-check
          "most default class cannot have any parent other than itself"
          (list class model-component))))

      ((equal? most-default-class superclass)
       'pass)

      (else

       (when (equal? default-key super-predicate)
         (fail-model-check
          (stringf "element superclass must refer to other superclass, or be ~s"
                   most-default-class)
          (list class model-component)))

       (unless (equal? 'union super-predicate)
         (fail-model-check
          (stringf "element superclass must refer to a ~s superclass"
                   (~s 'union))
          (list class model-component))))))

   model)

  (define superclasss
    (list->hashset
     (filter
      (comp (equal? most-default-class) not)
      (map
       (lambda (model-component)
         (define-tuple (class predicate superclass) model-component)
         superclass)
       model))))

  (define diff
    (hashset-difference
     superclasss classes/s))

  (unless (hashset-null? diff)
    (fail-model-check
     "every superclass must be a class itself"
     (list (hashset->list diff))))

  (define (checkloop start-model-component)
    (define S (make-hashset))
    (let loop ((current start-model-component))
      (define-tuple (class predicate superclass) current)
      (unless (equal? superclass most-default-class)
        (loop (or (assq superclass model)
                  (raisu 'impossible-17237123))))))

  (for-each checkloop model)

  )
