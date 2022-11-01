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

%run guile

%var descriptors-registry-get
%var descriptors-registry-set!
%var descritors-registry-decolisify-name

%use (builtin-descriptors) "./builtin-descriptors.scm"
%use (hashmap-count hashmap-ref hashmap-set! make-hashmap) "./ihashmap.scm"
%use (list-and-map) "./list-and-map.scm"
%use (raisu) "./raisu.scm"

(define descriptors-registry
  (let ((ret (make-hashmap)))
    (for-each
     (lambda (descriptor)
       (hashmap-set! ret (cdr (assoc 'name descriptor)) descriptor))
     builtin-descriptors)
    ret))

(define (descriptors-registry-get name)
  (hashmap-ref descriptors-registry name #f))

(define (descriptors-registry-set! name descriptor)
  (unless (and (list? descriptor)
               (list-and-map pair? descriptor))
    (raisu 'descriptor-must-be-an-association-list name descriptor))
  (unless (symbol? name)
    (raisu 'name-must-be-a-symbol name descriptor))
  (unless (equal? (cons 'name name)
                  (assoc 'name descriptor))
    (raisu 'descriptor-must-have-a-name-field name descriptor))

  (hashmap-set! descriptors-registry name descriptor))

(define (descritors-registry-decolisify-name name)
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
