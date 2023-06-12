;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define descriptors-registry
  (let ((ret (make-hashmap)))
    (for-each
     (lambda (descriptor)
       (hashmap-set! ret (cdr (assoc 'name descriptor)) descriptor))
     builtin-descriptors)
    ret))

(define (descriptors-registry-get name)
  (hashmap-ref descriptors-registry name #f))

(define (descriptors-registry-add! name descriptor)
  (unless (and (list? descriptor)
               (list-and-map pair? descriptor))
    (raisu 'descriptor-must-be-an-association-list name descriptor))
  (unless (symbol? name)
    (raisu 'name-must-be-a-symbol name descriptor))
  (when (assoc 'name descriptor)
    (raisu 'descriptor-begining-must-not-have-a-name-field descriptor))

  (let ((name2 (descriptors-registry-decolisify-name name)))
    (define descriptor2 (cons (cons 'name name2) descriptor))
    (hashmap-set! descriptors-registry name2 descriptor2)
    name2))

(define (descriptors-registry-decolisify-name name)
  (define (combine name suffix)
    (if (= 0 suffix) name
        (string->symbol
         (string-append
          (symbol->string name) "." (number->string suffix)))))
  (define top (+ 2 (hashmap-count descriptors-registry)))

  (unless (symbol? name)
    (raisu 'name-must-be-a-symbol name))

  (let loop ((suffix 0))
    (if (> suffix top) #f
        (let ((comb (combine name suffix)))
          (if (hashmap-ref descriptors-registry comb #f)
              (loop (+ 1 suffix))
              comb)))))
