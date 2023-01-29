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

%var define-type9
%var define-type9/nobind-descriptor
%var type9-get-record-descriptor
%var type9-get-descriptor-by-name

%use (define-dumb-record) "./define-dumb-record.scm"
%use (descriptors-registry-add! descriptors-registry-decolisify-name descriptors-registry-get) "./descriptors-registry.scm"
%use (raisu) "./raisu.scm"
%use (range) "./range.scm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Begin auto-generated content ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-dumb-record r0
  (r0-constructor :) r0-predicate
  (: r0-:-accessor))

(define-dumb-record r0m
  (r0m-constructor :) r0m-predicate
  (: r0m-:-accessor))

(define-dumb-record r1
  (r1-constructor : a) r1-predicate
  (: r1-:-accessor)
  (a r1-a-field-accessor))

(define-dumb-record r1m
  (r1m-constructor : a) r1m-predicate
  (: r1m-:-accessor)
  (a r1m-a-field-accessor r1m-a-field-setter))

(define-dumb-record r2
  (r2-constructor : a b) r2-predicate
  (: r2-:-accessor)
  (a r2-a-field-accessor)
  (b r2-b-field-accessor))

(define-dumb-record r2m
  (r2m-constructor : a b) r2m-predicate
  (: r2m-:-accessor)
  (a r2m-a-field-accessor r2m-a-field-setter)
  (b r2m-b-field-accessor r2m-b-field-setter))

(define-dumb-record r3
  (r3-constructor : a b c) r3-predicate
  (: r3-:-accessor)
  (a r3-a-field-accessor)
  (b r3-b-field-accessor)
  (c r3-c-field-accessor))

(define-dumb-record r3m
  (r3m-constructor : a b c) r3m-predicate
  (: r3m-:-accessor)
  (a r3m-a-field-accessor r3m-a-field-setter)
  (b r3m-b-field-accessor r3m-b-field-setter)
  (c r3m-c-field-accessor r3m-c-field-setter))

(define-dumb-record r4
  (r4-constructor : a b c d) r4-predicate
  (: r4-:-accessor)
  (a r4-a-field-accessor)
  (b r4-b-field-accessor)
  (c r4-c-field-accessor)
  (d r4-d-field-accessor))

(define-dumb-record r4m
  (r4m-constructor : a b c d) r4m-predicate
  (: r4m-:-accessor)
  (a r4m-a-field-accessor r4m-a-field-setter)
  (b r4m-b-field-accessor r4m-b-field-setter)
  (c r4m-c-field-accessor r4m-c-field-setter)
  (d r4m-d-field-accessor r4m-d-field-setter))

(define-dumb-record r5
  (r5-constructor : a b c d e) r5-predicate
  (: r5-:-accessor)
  (a r5-a-field-accessor)
  (b r5-b-field-accessor)
  (c r5-c-field-accessor)
  (d r5-d-field-accessor)
  (e r5-e-field-accessor))

(define-dumb-record r5m
  (r5m-constructor : a b c d e) r5m-predicate
  (: r5m-:-accessor)
  (a r5m-a-field-accessor r5m-a-field-setter)
  (b r5m-b-field-accessor r5m-b-field-setter)
  (c r5m-c-field-accessor r5m-c-field-setter)
  (d r5m-d-field-accessor r5m-d-field-setter)
  (e r5m-e-field-accessor r5m-e-field-setter))

(define-dumb-record r6
  (r6-constructor : a b c d e f) r6-predicate
  (: r6-:-accessor)
  (a r6-a-field-accessor)
  (b r6-b-field-accessor)
  (c r6-c-field-accessor)
  (d r6-d-field-accessor)
  (e r6-e-field-accessor)
  (f r6-f-field-accessor))

(define-dumb-record r6m
  (r6m-constructor : a b c d e f) r6m-predicate
  (: r6m-:-accessor)
  (a r6m-a-field-accessor r6m-a-field-setter)
  (b r6m-b-field-accessor r6m-b-field-setter)
  (c r6m-c-field-accessor r6m-c-field-setter)
  (d r6m-d-field-accessor r6m-d-field-setter)
  (e r6m-e-field-accessor r6m-e-field-setter)
  (f r6m-f-field-accessor r6m-f-field-setter))

(define-dumb-record r7
  (r7-constructor : a b c d e f g) r7-predicate
  (: r7-:-accessor)
  (a r7-a-field-accessor)
  (b r7-b-field-accessor)
  (c r7-c-field-accessor)
  (d r7-d-field-accessor)
  (e r7-e-field-accessor)
  (f r7-f-field-accessor)
  (g r7-g-field-accessor))

(define-dumb-record r7m
  (r7m-constructor : a b c d e f g) r7m-predicate
  (: r7m-:-accessor)
  (a r7m-a-field-accessor r7m-a-field-setter)
  (b r7m-b-field-accessor r7m-b-field-setter)
  (c r7m-c-field-accessor r7m-c-field-setter)
  (d r7m-d-field-accessor r7m-d-field-setter)
  (e r7m-e-field-accessor r7m-e-field-setter)
  (f r7m-f-field-accessor r7m-f-field-setter)
  (g r7m-g-field-accessor r7m-g-field-setter))

(define-dumb-record r8
  (r8-constructor : a b c d e f g h) r8-predicate
  (: r8-:-accessor)
  (a r8-a-field-accessor)
  (b r8-b-field-accessor)
  (c r8-c-field-accessor)
  (d r8-d-field-accessor)
  (e r8-e-field-accessor)
  (f r8-f-field-accessor)
  (g r8-g-field-accessor)
  (h r8-h-field-accessor))

(define-dumb-record r8m
  (r8m-constructor : a b c d e f g h) r8m-predicate
  (: r8m-:-accessor)
  (a r8m-a-field-accessor r8m-a-field-setter)
  (b r8m-b-field-accessor r8m-b-field-setter)
  (c r8m-c-field-accessor r8m-c-field-setter)
  (d r8m-d-field-accessor r8m-d-field-setter)
  (e r8m-e-field-accessor r8m-e-field-setter)
  (f r8m-f-field-accessor r8m-f-field-setter)
  (g r8m-g-field-accessor r8m-g-field-setter)
  (h r8m-h-field-accessor r8m-h-field-setter))

(define-dumb-record r9
  (r9-constructor : a b c d e f g h i) r9-predicate
  (: r9-:-accessor)
  (a r9-a-field-accessor)
  (b r9-b-field-accessor)
  (c r9-c-field-accessor)
  (d r9-d-field-accessor)
  (e r9-e-field-accessor)
  (f r9-f-field-accessor)
  (g r9-g-field-accessor)
  (h r9-h-field-accessor)
  (i r9-i-field-accessor))

(define-dumb-record r9m
  (r9m-constructor : a b c d e f g h i) r9m-predicate
  (: r9m-:-accessor)
  (a r9m-a-field-accessor r9m-a-field-setter)
  (b r9m-b-field-accessor r9m-b-field-setter)
  (c r9m-c-field-accessor r9m-c-field-setter)
  (d r9m-d-field-accessor r9m-d-field-setter)
  (e r9m-e-field-accessor r9m-e-field-setter)
  (f r9m-f-field-accessor r9m-f-field-setter)
  (g r9m-g-field-accessor r9m-g-field-setter)
  (h r9m-h-field-accessor r9m-h-field-setter)
  (i r9m-i-field-accessor r9m-i-field-setter))

(define type9-immutable-constructors
  (vector r0-constructor r1-constructor r2-constructor r3-constructor r4-constructor r5-constructor r6-constructor r7-constructor r8-constructor r9-constructor))

(define type9-mutable-constructors
  (vector r0m-constructor r1m-constructor r2m-constructor r3m-constructor r4m-constructor r5m-constructor r6m-constructor r7m-constructor r8m-constructor r9m-constructor))

(define type9-immutable-predicates
  (vector r0-predicate r1-predicate r2-predicate r3-predicate r4-predicate r5-predicate r6-predicate r7-predicate r8-predicate r9-predicate))

(define type9-mutable-predicates
  (vector r0m-predicate r1m-predicate r2m-predicate r3m-predicate r4m-predicate r5m-predicate r6m-predicate r7m-predicate r8m-predicate r9m-predicate))

(define type9-immutable-:-accessors
  (vector r0-:-accessor r1-:-accessor r2-:-accessor r3-:-accessor r4-:-accessor r5-:-accessor r6-:-accessor r7-:-accessor r8-:-accessor r9-:-accessor))

(define type9-mutable-:-accessors
  (vector r0m-:-accessor r1m-:-accessor r2m-:-accessor r3m-:-accessor r4m-:-accessor r5m-:-accessor r6m-:-accessor r7m-:-accessor r8m-:-accessor r9m-:-accessor))

(define type9-immutable-accessors
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
    (vector r9-a-field-accessor r9-b-field-accessor r9-c-field-accessor r9-d-field-accessor r9-e-field-accessor r9-f-field-accessor r9-g-field-accessor r9-h-field-accessor r9-i-field-accessor)))

(define type9-mutable-accessors
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
    (vector r9m-a-field-accessor r9m-b-field-accessor r9m-c-field-accessor r9m-d-field-accessor r9m-e-field-accessor r9m-f-field-accessor r9m-g-field-accessor r9m-h-field-accessor r9m-i-field-accessor)))

(define type9-mutable-setters
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
    (vector r9m-a-field-setter r9m-b-field-setter r9m-c-field-setter r9m-d-field-setter r9m-e-field-setter r9m-f-field-setter r9m-g-field-setter r9m-h-field-setter r9m-i-field-setter)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of auto-generated content ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Begin helper functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (type9-get-immutable-predicate n)
  (unless (< n (vector-length type9-immutable-predicates))
    (raisu 'do-not-have-that-many-predicates n))
  (vector-ref type9-immutable-predicates n))

(define (type9-get-mutable-predicate n)
  (unless (< n (vector-length type9-mutable-predicates))
    (raisu 'do-not-have-that-many-predicates n))
  (vector-ref type9-mutable-predicates n))

(define (type9-get-immutable-constructor n)
  (unless (< n (vector-length type9-immutable-constructors))
    (raisu 'do-not-have-that-many-constructors n))
  (vector-ref type9-immutable-constructors n))

(define (type9-get-mutable-constructor n)
  (unless (< n (vector-length type9-mutable-constructors))
    (raisu 'do-not-have-that-many-constructors n))
  (vector-ref type9-mutable-constructors n))

(define (type9-get-immutable-:-accessor n)
  (unless (< n (vector-length type9-immutable-:-accessors))
    (raisu 'do-not-have-that-many-:-accessors n))
  (vector-ref type9-immutable-:-accessors n))

(define (type9-get-mutable-:-accessor n)
  (unless (< n (vector-length type9-mutable-:-accessors))
    (raisu 'do-not-have-that-many-:-accessors n))
  (vector-ref type9-mutable-:-accessors n))

(define (type9-get-immutable-accessor n k)
  (unless (< n (vector-length type9-immutable-accessors))
    (raisu 'do-not-have-that-many-record-templates n))
  (let* ((v (vector-ref type9-immutable-accessors n)))
    (unless (< k (vector-length v))
      (raisu 'do-not-have-that-many-accessors n))
    (vector-ref v k)))

(define (type9-get-mutable-accessor n k)
  (unless (< n (vector-length type9-mutable-accessors))
    (raisu 'do-not-have-that-many-record-templates n))
  (let* ((v (vector-ref type9-mutable-accessors n)))
    (unless (< k (vector-length v))
      (raisu 'do-not-have-that-many-accessors n))
    (vector-ref v k)))

(define (type9-get-mutable-setter n k)
  (unless (< n (vector-length type9-mutable-setters))
    (raisu 'do-not-have-that-many-record-templates n))
  (let* ((v (vector-ref type9-mutable-setters n)))
    (unless (< k (vector-length v))
      (raisu 'do-not-have-that-many-setters n))
    (vector-ref v k)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of helper functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (type9-register-descriptor! name constructor predicate mutable? fields)
  (define descriptor-begining
    `((constructor . ,constructor)
      (arity . ,(length fields))
      (predicate . ,predicate)
      (mutable? . ,mutable?)
      (fields . ,fields)
      (builtin . #f)
      ))
  (descriptors-registry-add! name descriptor-begining))

;; Returns #f if record is not a type9 record.
(define (type9-get-record-name record)
  (define N (vector-length type9-immutable-predicates))
  (define (check-immutable n)
    (define predicate (vector-ref type9-immutable-predicates n))
    (and (predicate record)
         (let ((:-accessor (vector-ref type9-immutable-:-accessors n)))
           (:-accessor record))))
  (define (check-mutable n)
    (define predicate (vector-ref type9-mutable-predicates n))
    (and (predicate record)
         (let ((:-accessor (vector-ref type9-mutable-:-accessors n)))
           (:-accessor record))))
  (define (check n) (or (check-immutable n) (check-mutable n)))

  (or (let loop ((n 1))
        (and (< n N)
             (or (check n)
                 (loop (+ 1 n)))))
      (check 0)))

(define (type9-get-record-descriptor record)
  (define name (type9-get-record-name record))
  (and name (descriptors-registry-get name)))

(define (type9-define-things qq)
  (define name0 (list-ref qq 0))
  (define name (descriptors-registry-decolisify-name name0))
  (define constructor-group (list-ref qq 1))
  (define field-names (cdr constructor-group))
  (define field-specs (list-ref qq 3))
  (define mutable?
    (not
     (null?
      (filter
       (lambda (p) (< 2 (length p)))
       field-specs))))
  (define n (length field-names))

  (define (get field-index)
    (define mut-field?
      (< 2 (length (list-ref field-specs field-index))))
    (if mutable?
        (if mut-field?
            (list (type9-get-mutable-accessor n field-index)
                  (type9-get-mutable-setter n field-index))
            (list (type9-get-mutable-accessor n field-index)))
        (list (type9-get-immutable-accessor n field-index))))

  (define constructor0
    (if mutable?
        (type9-get-mutable-constructor n)
        (type9-get-immutable-constructor n)))

  (define (constructor . args)
    (unless (= n (length args))
      (raisu 'constructor-expects-a-differrent-number-of-arguments
             n (length args) name))
    (apply constructor0 (cons name args)))

  (define predicate0
    (if mutable?
        (type9-get-mutable-predicate n)
        (type9-get-immutable-predicate n)))

  (define :-accessor
    (if mutable?
        (type9-get-mutable-:-accessor n)
        (type9-get-immutable-:-accessor n)))

  (define predicate
    (lambda (obj)
      (and (predicate0 obj)
           (equal? name (:-accessor obj)))))

  (define fields
    (map get (range n)))

  (define ret
    (cons
     name
     (cons
      constructor
      (cons
       predicate
       (apply
        append
        (reverse fields))))))

  (define named-fields
    (map (lambda (field-name field) (cons field-name field))
         field-names fields))
  (type9-register-descriptor! name constructor predicate mutable? named-fields)

  ret)

(define-syntax define-type9-helper
  (syntax-rules ()
    ((_ buf body name constructor-name predicate-name)
     (define-values (name constructor-name predicate-name . buf)
       (apply values body)))
    ((_ buf body name constructor-name predicate-name (field-name field-accessor) . field-specs)
     (define-type9-helper (field-accessor . buf) body name constructor-name predicate-name . field-specs))
    ((_ buf body name constructor-name predicate-name (field-name field-accessor field-setter) . field-specs)
     (define-type9-helper (field-accessor field-setter . buf) body name constructor-name predicate-name . field-specs))
    ))

(define-syntax define-type9
  (syntax-rules ()
    ((_ name
        (constructor-name . field-names)
        predicate-name
        . field-specs)
     (define-type9-helper
       ()
       (type9-define-things
        (quote (name
                (constructor-name . field-names)
                predicate-name
                field-specs)))
       name constructor-name predicate-name . field-specs))))

(define-syntax define-type9/nobind-descriptor-helper
  (syntax-rules ()
    ((_ buf body constructor-name predicate-name)
     (define-values (constructor-name predicate-name . buf)
       (apply values body)))
    ((_ buf body constructor-name predicate-name (field-name field-accessor) . field-specs)
     (define-type9/nobind-descriptor-helper (field-accessor . buf) body constructor-name predicate-name . field-specs))
    ((_ buf body constructor-name predicate-name (field-name field-accessor field-setter) . field-specs)
     (define-type9/nobind-descriptor-helper (field-accessor field-setter . buf) body constructor-name predicate-name . field-specs))
    ))

(define-syntax define-type9/nobind-descriptor
  (syntax-rules ()
    ((_ (constructor-name . field-names)
        predicate-name
        . field-specs)
     (define-type9/nobind-descriptor-helper
       ()
       (cdr
        (type9-define-things
         (quote (constructor-name
                 (constructor-name . field-names)
                 predicate-name
                 field-specs))))
       constructor-name predicate-name . field-specs))))
