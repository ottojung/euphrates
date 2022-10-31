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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Begin auto-generated content ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-type9 r0
  (r0-constructor id) r0-predicate
  (id r0-id-accessor))

(define-type9 r0m
  (r0m-constructor id) r0m-predicate
  (id r0m-id-accessor))

(define-type9 r1
  (r1-constructor id a) r1-predicate
  (id r1-id-accessor)
  (a r1-a-field-accessor))

(define-type9 r1m
  (r1m-constructor id a) r1m-predicate
  (id r1m-id-accessor)
  (a r1m-a-field-accessor r1m-a-field-setter))

(define-type9 r2
  (r2-constructor id a b) r2-predicate
  (id r2-id-accessor)
  (a r2-a-field-accessor)
  (b r2-b-field-accessor))

(define-type9 r2m
  (r2m-constructor id a b) r2m-predicate
  (id r2m-id-accessor)
  (a r2m-a-field-accessor r2m-a-field-setter)
  (b r2m-b-field-accessor r2m-b-field-setter))

(define-type9 r3
  (r3-constructor id a b c) r3-predicate
  (id r3-id-accessor)
  (a r3-a-field-accessor)
  (b r3-b-field-accessor)
  (c r3-c-field-accessor))

(define-type9 r3m
  (r3m-constructor id a b c) r3m-predicate
  (id r3m-id-accessor)
  (a r3m-a-field-accessor r3m-a-field-setter)
  (b r3m-b-field-accessor r3m-b-field-setter)
  (c r3m-c-field-accessor r3m-c-field-setter))

(define-type9 r4
  (r4-constructor id a b c d) r4-predicate
  (id r4-id-accessor)
  (a r4-a-field-accessor)
  (b r4-b-field-accessor)
  (c r4-c-field-accessor)
  (d r4-d-field-accessor))

(define-type9 r4m
  (r4m-constructor id a b c d) r4m-predicate
  (id r4m-id-accessor)
  (a r4m-a-field-accessor r4m-a-field-setter)
  (b r4m-b-field-accessor r4m-b-field-setter)
  (c r4m-c-field-accessor r4m-c-field-setter)
  (d r4m-d-field-accessor r4m-d-field-setter))

(define-type9 r5
  (r5-constructor id a b c d e) r5-predicate
  (id r5-id-accessor)
  (a r5-a-field-accessor)
  (b r5-b-field-accessor)
  (c r5-c-field-accessor)
  (d r5-d-field-accessor)
  (e r5-e-field-accessor))

(define-type9 r5m
  (r5m-constructor id a b c d e) r5m-predicate
  (id r5m-id-accessor)
  (a r5m-a-field-accessor r5m-a-field-setter)
  (b r5m-b-field-accessor r5m-b-field-setter)
  (c r5m-c-field-accessor r5m-c-field-setter)
  (d r5m-d-field-accessor r5m-d-field-setter)
  (e r5m-e-field-accessor r5m-e-field-setter))

(define-type9 r6
  (r6-constructor id a b c d e f) r6-predicate
  (id r6-id-accessor)
  (a r6-a-field-accessor)
  (b r6-b-field-accessor)
  (c r6-c-field-accessor)
  (d r6-d-field-accessor)
  (e r6-e-field-accessor)
  (f r6-f-field-accessor))

(define-type9 r6m
  (r6m-constructor id a b c d e f) r6m-predicate
  (id r6m-id-accessor)
  (a r6m-a-field-accessor r6m-a-field-setter)
  (b r6m-b-field-accessor r6m-b-field-setter)
  (c r6m-c-field-accessor r6m-c-field-setter)
  (d r6m-d-field-accessor r6m-d-field-setter)
  (e r6m-e-field-accessor r6m-e-field-setter)
  (f r6m-f-field-accessor r6m-f-field-setter))

(define-type9 r7
  (r7-constructor id a b c d e f g) r7-predicate
  (id r7-id-accessor)
  (a r7-a-field-accessor)
  (b r7-b-field-accessor)
  (c r7-c-field-accessor)
  (d r7-d-field-accessor)
  (e r7-e-field-accessor)
  (f r7-f-field-accessor)
  (g r7-g-field-accessor))

(define-type9 r7m
  (r7m-constructor id a b c d e f g) r7m-predicate
  (id r7m-id-accessor)
  (a r7m-a-field-accessor r7m-a-field-setter)
  (b r7m-b-field-accessor r7m-b-field-setter)
  (c r7m-c-field-accessor r7m-c-field-setter)
  (d r7m-d-field-accessor r7m-d-field-setter)
  (e r7m-e-field-accessor r7m-e-field-setter)
  (f r7m-f-field-accessor r7m-f-field-setter)
  (g r7m-g-field-accessor r7m-g-field-setter))

(define-type9 r8
  (r8-constructor id a b c d e f g h) r8-predicate
  (id r8-id-accessor)
  (a r8-a-field-accessor)
  (b r8-b-field-accessor)
  (c r8-c-field-accessor)
  (d r8-d-field-accessor)
  (e r8-e-field-accessor)
  (f r8-f-field-accessor)
  (g r8-g-field-accessor)
  (h r8-h-field-accessor))

(define-type9 r8m
  (r8m-constructor id a b c d e f g h) r8m-predicate
  (id r8m-id-accessor)
  (a r8m-a-field-accessor r8m-a-field-setter)
  (b r8m-b-field-accessor r8m-b-field-setter)
  (c r8m-c-field-accessor r8m-c-field-setter)
  (d r8m-d-field-accessor r8m-d-field-setter)
  (e r8m-e-field-accessor r8m-e-field-setter)
  (f r8m-f-field-accessor r8m-f-field-setter)
  (g r8m-g-field-accessor r8m-g-field-setter)
  (h r8m-h-field-accessor r8m-h-field-setter))

(define-type9 r9
  (r9-constructor id a b c d e f g h i) r9-predicate
  (id r9-id-accessor)
  (a r9-a-field-accessor)
  (b r9-b-field-accessor)
  (c r9-c-field-accessor)
  (d r9-d-field-accessor)
  (e r9-e-field-accessor)
  (f r9-f-field-accessor)
  (g r9-g-field-accessor)
  (h r9-h-field-accessor)
  (i r9-i-field-accessor))

(define-type9 r9m
  (r9m-constructor id a b c d e f g h i) r9m-predicate
  (id r9m-id-accessor)
  (a r9m-a-field-accessor r9m-a-field-setter)
  (b r9m-b-field-accessor r9m-b-field-setter)
  (c r9m-c-field-accessor r9m-c-field-setter)
  (d r9m-d-field-accessor r9m-d-field-setter)
  (e r9m-e-field-accessor r9m-e-field-setter)
  (f r9m-f-field-accessor r9m-f-field-setter)
  (g r9m-g-field-accessor r9m-g-field-setter)
  (h r9m-h-field-accessor r9m-h-field-setter)
  (i r9m-i-field-accessor r9m-i-field-setter))

(define-type9 r10
  (r10-constructor id a b c d e f g h i j) r10-predicate
  (id r10-id-accessor)
  (a r10-a-field-accessor)
  (b r10-b-field-accessor)
  (c r10-c-field-accessor)
  (d r10-d-field-accessor)
  (e r10-e-field-accessor)
  (f r10-f-field-accessor)
  (g r10-g-field-accessor)
  (h r10-h-field-accessor)
  (i r10-i-field-accessor)
  (j r10-j-field-accessor))

(define-type9 r10m
  (r10m-constructor id a b c d e f g h i j) r10m-predicate
  (id r10m-id-accessor)
  (a r10m-a-field-accessor r10m-a-field-setter)
  (b r10m-b-field-accessor r10m-b-field-setter)
  (c r10m-c-field-accessor r10m-c-field-setter)
  (d r10m-d-field-accessor r10m-d-field-setter)
  (e r10m-e-field-accessor r10m-e-field-setter)
  (f r10m-f-field-accessor r10m-f-field-setter)
  (g r10m-g-field-accessor r10m-g-field-setter)
  (h r10m-h-field-accessor r10m-h-field-setter)
  (i r10m-i-field-accessor r10m-i-field-setter)
  (j r10m-j-field-accessor r10m-j-field-setter))

(define type8-immutable-constructors
  (vector r0-constructor r1-constructor r2-constructor r3-constructor r4-constructor r5-constructor r6-constructor r7-constructor r8-constructor r9-constructor r10-constructor))

(define type8-mutable-constructors
  (vector r0-constructor r1-constructor r2-constructor r3-constructor r4-constructor r5-constructor r6-constructor r7-constructor r8-constructor r9-constructor r10-constructor))

(define type8-immutable-predicates
  (vector r0-predicate r1-predicate r2-predicate r3-predicate r4-predicate r5-predicate r6-predicate r7-predicate r8-predicate r9-predicate r10-predicate))

(define type8-mutable-predicates
  (vector r0-predicate r1-predicate r2-predicate r3-predicate r4-predicate r5-predicate r6-predicate r7-predicate r8-predicate r9-predicate r10-predicate))

(define type8-immutable-accessors
  (vector
    (vector)
    (vector r1-a-field-accessor)
    (vector r2-a-field-accessor r2-b-field-accessor)
    (vector r3-a-field-accessor r3-b-field-accessor r3-c-field-accessor)
    (vector r4-a-field-accessor r4-b-field-accessor r4-c-field-accessor r4-d-field-accessor)
    (vector r5-a-field-accessor r5-b-field-accessor r5-c-field-accessor r5-d-field-accessor r5-e-field-accessor)
    (vector r6-a-field-accessor r6-b-field-accessor r6-c-field-accessor r6-d-field-accessor r6-e-field-accessor r6-f-field-accessor)
    (vector r7-a-field-accessor r7-b-field-accessor r7-c-field-accessor r7-d-field-accessor r7-e-field-accessor r7-f-field-accessor r7-g-field-accessor)
    (vector r8-a-field-accessor r8-b-field-accessor r8-c-field-accessor r8-d-field-accessor r8-e-field-accessor r8-f-field-accessor r8-g-field-accessor r8-h-field-accessor)
    (vector r9-a-field-accessor r9-b-field-accessor r9-c-field-accessor r9-d-field-accessor r9-e-field-accessor r9-f-field-accessor r9-g-field-accessor r9-h-field-accessor r9-i-field-accessor)
    (vector r10-a-field-accessor r10-b-field-accessor r10-c-field-accessor r10-d-field-accessor r10-e-field-accessor r10-f-field-accessor r10-g-field-accessor r10-h-field-accessor r10-i-field-accessor r10-j-field-accessor)))

(define type8-mutable-accessors
  (vector
    (vector)
    (vector r1m-a-field-accessor)
    (vector r2m-a-field-accessor r2m-b-field-accessor)
    (vector r3m-a-field-accessor r3m-b-field-accessor r3m-c-field-accessor)
    (vector r4m-a-field-accessor r4m-b-field-accessor r4m-c-field-accessor r4m-d-field-accessor)
    (vector r5m-a-field-accessor r5m-b-field-accessor r5m-c-field-accessor r5m-d-field-accessor r5m-e-field-accessor)
    (vector r6m-a-field-accessor r6m-b-field-accessor r6m-c-field-accessor r6m-d-field-accessor r6m-e-field-accessor r6m-f-field-accessor)
    (vector r7m-a-field-accessor r7m-b-field-accessor r7m-c-field-accessor r7m-d-field-accessor r7m-e-field-accessor r7m-f-field-accessor r7m-g-field-accessor)
    (vector r8m-a-field-accessor r8m-b-field-accessor r8m-c-field-accessor r8m-d-field-accessor r8m-e-field-accessor r8m-f-field-accessor r8m-g-field-accessor r8m-h-field-accessor)
    (vector r9m-a-field-accessor r9m-b-field-accessor r9m-c-field-accessor r9m-d-field-accessor r9m-e-field-accessor r9m-f-field-accessor r9m-g-field-accessor r9m-h-field-accessor r9m-i-field-accessor)
    (vector r10m-a-field-accessor r10m-b-field-accessor r10m-c-field-accessor r10m-d-field-accessor r10m-e-field-accessor r10m-f-field-accessor r10m-g-field-accessor r10m-h-field-accessor r10m-i-field-accessor r10m-j-field-accessor)))

(define type8-mutable-setters
  (vector
    (vector)
    (vector r1m-a-field-setter)
    (vector r2m-a-field-setter r2m-b-field-setter)
    (vector r3m-a-field-setter r3m-b-field-setter r3m-c-field-setter)
    (vector r4m-a-field-setter r4m-b-field-setter r4m-c-field-setter r4m-d-field-setter)
    (vector r5m-a-field-setter r5m-b-field-setter r5m-c-field-setter r5m-d-field-setter r5m-e-field-setter)
    (vector r6m-a-field-setter r6m-b-field-setter r6m-c-field-setter r6m-d-field-setter r6m-e-field-setter r6m-f-field-setter)
    (vector r7m-a-field-setter r7m-b-field-setter r7m-c-field-setter r7m-d-field-setter r7m-e-field-setter r7m-f-field-setter r7m-g-field-setter)
    (vector r8m-a-field-setter r8m-b-field-setter r8m-c-field-setter r8m-d-field-setter r8m-e-field-setter r8m-f-field-setter r8m-g-field-setter r8m-h-field-setter)
    (vector r9m-a-field-setter r9m-b-field-setter r9m-c-field-setter r9m-d-field-setter r9m-e-field-setter r9m-f-field-setter r9m-g-field-setter r9m-h-field-setter r9m-i-field-setter)
    (vector r10m-a-field-setter r10m-b-field-setter r10m-c-field-setter r10m-d-field-setter r10m-e-field-setter r10m-f-field-setter r10m-g-field-setter r10m-h-field-setter r10m-i-field-setter r10m-j-field-setter)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of auto-generated content ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
