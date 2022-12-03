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

%var serialize/short
%var deserialize/short

%use (assoc-or) "./assoc-or.scm"
%use (descriptors-registry-get) "./descriptors-registry.scm"
%use (raisu) "./raisu.scm"
%use (deserialize/sexp/short serialize/sexp/short) "./serialization-sexp-short.scm"
%use (string-drop-n) "./string-drop-n.scm"

(define (serialize-type9/short obj r9d loop)
  (define fields (assoc-or 'fields r9d (raisu 'no-fields-in-r9d r9d obj)))
  (define name (cdr (assoc 'name r9d)))
  (define @name (string->symbol (string-append "@" (symbol->string name))))
  (cons @name
        (map (lambda (field)
               (define name (list-ref field 0))
               (define accessor (list-ref field 1))
               (list name (loop (accessor obj)))) fields)))

(define serialize/short
  (serialize/sexp/short
   serialize-type9/short (const '(procedure ???))))

(define (deserialize-type9-fields/short obj r9d loop)
  (define fields (assoc-or 'fields r9d (raisu 'no-fields-in-r9d r9d obj)))
  (define n (length fields))
  (define se-fields (cdr obj))
  (define args
    (map
     (lambda (field)
       (define name (car field))
       (define arg/l (assoc-or name se-fields (raisu 'serialized-record-missing-a-field name obj)))
       (define arg (car arg/l))
       arg)
     fields))
  (map loop args))

(define (deserialize-type9/short o loop)
  (when (or (not (list? o))
            (null? o))
    (raisu 'bad-format:expecting-list o))
  (unless (symbol? (car o))
    (raisu 'bad-format:expecting-symbol-at-pos-0 o))

  (let* ((name-with-@ (car o))
         (name/s (symbol->string name-with-@)))
    (unless (string-prefix? "@" name/s)
      (raisu 'bad-format:must-start-with-@ o))
    (let* ((name (string-drop-n 1 name/s))
           (r9d (or (descriptors-registry-get name)
                    (raisu 'unkown-type-tag name))))
      (define constructor (assoc-or 'constructor r9d (raisu 'no-constructor-in-descriptor r9d)))
      (define args (deserialize-type9-fields/short o r9d loop))
      (apply constructor args))))

(define deserialize/short
  (deserialize/sexp/short
   deserialize-type9/short
   (lambda (o)
     (and (equal? o '(procedure))
          (raisu 'cannot-deserialize-procedures o)))))
