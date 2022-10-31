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

%var define-type8

%use (debugv) "./debugv.scm"
%use (define-type9) "./define-type9.scm"
%use (make-hashmap) "./ihashmap.scm"
%use (list-or-map) "./list-or-map.scm"
%use (raisu) "./raisu.scm"
%use (range) "./range.scm"

(define-type9 r0
  (r0-constructor id) r0-predicate
  (id r0-id-accessor)
  )

(define-type9 r1
  (r1-constructor id a) r1-predicate
  (id r1-id-accessor)
  (a r1-a-field-accessor)
  )

(define-type9 r2
  (r2-constructor id a b) r2-predicate
  (id r2-id-accessor)
  (a r2-a-field-accessor)
  (b r2-b-field-accessor)
  )

(define-type9 r0m
  (r0m-constructor id) r0m-predicate
  (id r0m-id-accessor)
  )

(define-type9 r1m
  (r1m-constructor id a) r1m-predicate
  (id r1m-id-accessor)
  (a r1m-a-field-accessor r1m-a-field-setter)
  )

(define-type9 r2m
  (r2m-constructor id a b) r2m-predicate
  (id r2m-id-accessor)
  (a r2m-a-field-accessor r2m-a-field-setter)
  (b r2m-b-field-accessor r2m-b-field-setter)
  )

(define type8-immutable-constructors
  (vector r0-constructor r1-constructor r2-constructor))

(define type8-mutable-constructors
  (vector r0m-constructor r1m-constructor r2m-constructor))

(define type8-immutable-predicates
  (vector r0-predicate r1-predicate r2-predicate))

(define type8-mutable-predicates
  (vector r0m-predicate r1m-predicate r2m-predicate))

(define type8-immutable-accessors
  (vector (vector)
          (vector r1-a-field-accessor)
          (vector r2-a-field-accessor r2-b-field-accessor)))

(define type8-mutable-accessors
  (vector (vector)
          (vector r1m-a-field-accessor)
          (vector r2m-a-field-accessor r2m-b-field-accessor)))

(define type8-mutable-setters
  (vector (vector)
          (vector r1m-a-field-setter)
          (vector r2m-a-field-setter r2m-b-field-setter)))

;;;; END OF GENERATED CONTENT ;;;

(define type8-id-hashmap
  (make-hashmap))

(define (type8-get-immutable-predicate n)
  (unless (< n (vector-length type8-immutable-predicates))
    (raisu 'do-not-have-that-many-predicates n))
  (vector-ref type8-immutable-predicates n))

(define (type8-get-mutable-predicate n)
  (unless (< n (vector-length type8-mutable-predicates))
    (raisu 'do-not-have-that-many-predicates n))
  (vector-ref type8-mutable-predicates n))

(define (type8-get-immutable-constructor n)
  (unless (< n (vector-length type8-immutable-constructors))
    (raisu 'do-not-have-that-many-constructors n))
  (vector-ref type8-immutable-constructors n))

(define (type8-get-mutable-constructor n)
  (unless (< n (vector-length type8-mutable-constructors))
    (raisu 'do-not-have-that-many-constructors n))
  (vector-ref type8-mutable-constructors n))

(define (type8-get-immutable-accessor n k)
  (unless (< n (vector-length type8-immutable-accessors))
    (raisu 'do-not-have-that-many-record-templates n))
  (let* ((v (vector-ref type8-immutable-accessors n)))
    (unless (< k (vector-length v))
      (raisu 'do-not-have-that-many-accessors n))
    (vector-ref v k)))

(define (type8-get-mutable-accessor n k)
  (unless (< n (vector-length type8-mutable-accessors))
    (raisu 'do-not-have-that-many-record-templates n))
  (let* ((v (vector-ref type8-mutable-accessors n)))
    (unless (< k (vector-length v))
      (raisu 'do-not-have-that-many-accessors n))
    (vector-ref v k)))

(define (type8-get-mutable-setter n k)
  (unless (< n (vector-length type8-mutable-setters))
    (raisu 'do-not-have-that-many-record-templates n))
  (let* ((v (vector-ref type8-mutable-setters n)))
    (unless (< k (vector-length v))
      (raisu 'do-not-have-that-many-setters n))
    (vector-ref v k)))

(define (type8-define-things qq)
  (define name (list-ref qq 0))
  (debugv name)
  (define constructor-group (list-ref qq 1))
  (debugv constructor-group)
  (define field-names (cdr constructor-group))
  (debugv field-names)
  (define field-specs (list-ref qq 3))
  (debugv field-specs)
  (define mutable?
    (list-or-map
     (lambda (p) (< 2 (length p)))
     field-specs))
  (debugv mutable?)
  (define n (length field-names))
  (debugv n)

  (define (get field-index)
    (define mut-field?
      (< 2 (length (list-ref field-specs field-index))))
    (if mutable?
        (if mut-field?
            (list (type8-get-mutable-accessor n field-index)
                  (type8-get-mutable-setter n field-index))
            (list (type8-get-mutable-accessor n field-index)))
        (list (type8-get-immutable-accessor n field-index))))

  (define constructor
    (if mutable?
        (type8-get-immutable-constructor n)
        (type8-get-mutable-constructor n)))

  (define predicate
    (if mutable?
        (type8-get-immutable-predicate n)
        (type8-get-mutable-predicate n)))

  (define ret
    (cons
     constructor
     (cons
      predicate
      (apply
       append
       (reverse
        (map get (range n)))))))

  (debugv (length ret))

  (apply values ret))

(define-syntax define-type8-helper
  (syntax-rules ()
    ((_ buf body constructor-name predicate-name)
     (define-values (constructor-name predicate-name . buf)
       (let ()
       (debugv (quote (constructor-name predicate-name . buf)))
       body)))
    ((_ buf body constructor-name predicate-name (field-name field-accessor) . field-specs)
     (define-type8-helper (field-accessor . buf) body constructor-name predicate-name . field-specs))
    ((_ buf body constructor-name predicate-name (field-name field-accessor field-setter) . field-specs)
     (define-type8-helper (field-accessor field-setter . buf) body constructor-name predicate-name . field-specs))
    ))

(define-syntax define-type8
  (syntax-rules ()
    ((_ name
        (constructor-name . field-names)
        predicate-name
        . field-specs)
     (define-type8-helper
       ()
       (type8-define-things
        (quote (name
                (constructor-name . field-names)
                predicate-name
                field-specs)))
       constructor-name predicate-name . field-specs))))
