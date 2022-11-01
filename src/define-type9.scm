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
%var type9-get-record-descriptor
%var type9-get-descriptor-by-name

%use (builtin-descriptors) "./builtin-descriptors.scm"
%use (define-dumb-record) "./define-dumb-record.scm"
%use (hashmap-count hashmap-ref hashmap-set! make-hashmap) "./ihashmap.scm"
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

(define type9-immutable-constructors
  (vector r0-constructor r1-constructor r2-constructor r3-constructor))

(define type9-mutable-constructors
  (vector r0m-constructor r1m-constructor r2m-constructor r3m-constructor))

(define type9-immutable-predicates
  (vector r0-predicate r1-predicate r2-predicate r3-predicate))

(define type9-mutable-predicates
  (vector r0m-predicate r1m-predicate r2m-predicate r3m-predicate))

(define type9-immutable-:-accessors
  (vector r0-:-accessor r1-:-accessor r2-:-accessor r3-:-accessor))

(define type9-mutable-:-accessors
  (vector r0m-:-accessor r1m-:-accessor r2m-:-accessor r3m-:-accessor))

(define type9-immutable-accessors
  (vector
    (vector)
    (vector r1-a-field-accessor)
    (vector r2-a-field-accessor r2-b-field-accessor)
    (vector r3-a-field-accessor r3-b-field-accessor r3-c-field-accessor)))

(define type9-mutable-accessors
  (vector
    (vector)
    (vector r1m-a-field-accessor)
    (vector r2m-a-field-accessor r2m-b-field-accessor)
    (vector r3m-a-field-accessor r3m-b-field-accessor r3m-c-field-accessor)))

(define type9-mutable-setters
  (vector
    (vector)
    (vector r1m-a-field-setter)
    (vector r2m-a-field-setter r2m-b-field-setter)
    (vector r3m-a-field-setter r3m-b-field-setter r3m-c-field-setter)))

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

(define type9-descriptor-hashmap
  (let ((ret (make-hashmap)))
    (for-each
     (lambda (descriptor)
       (hashmap-set! ret (cdr (assoc 'name descriptor)) descriptor))
     builtin-descriptors)
    ret))

(define (type9-decolisify-name name)
  (define (combine name suffix)
    (if (= 0 suffix) name
        (string->symbol
         (string-append
          (symbol->string name) "." (number->string suffix)))))
  (define top (+ 2 (hashmap-count type9-descriptor-hashmap)))

  (let loop ((suffix 0))
    (if (> suffix top) #f
        (let ((comb (combine name suffix)))
          (if (hashmap-ref type9-descriptor-hashmap comb #f)
              (loop (+ 1 suffix))
              comb)))))

(define (type9-register-descriptor! name constructor predicate mutable? fields)
  (define descriptor
    `((name . ,name)
      (constructor . ,constructor)
      (arity . ,(length fields))
      (predicate . ,predicate)
      (mutable? . ,mutable?)
      (fields . ,fields)
      (builtin . #f)
      ))
  (hashmap-set! type9-descriptor-hashmap name descriptor))

(define (type9-get-descriptor-by-name name)
  (hashmap-ref type9-descriptor-hashmap name #f))

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
        (and (<= n N)
             (or (check n)
                 (loop (+ 1 n)))))
      (check 0)))

(define (type9-get-record-descriptor record)
  (define name (type9-get-record-name record))
  (and name (type9-get-descriptor-by-name name)))

(define (type9-define-things qq)
  (define name0 (list-ref qq 0))
  (define name (type9-decolisify-name name0))
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
        (type9-get-immutable-constructor n)
        (type9-get-mutable-constructor n)))

  (define (constructor . args)
    (unless (= n (length args))
      (raisu 'constructor-expects-a-differrent-number-of-arguments
             n (length args) name))
    (apply constructor0 (cons name args)))

  (define predicate
    (if mutable?
        (type9-get-immutable-predicate n)
        (type9-get-mutable-predicate n)))

  (define fields
    (map get (range n)))

  (define ret
    (cons
     constructor
     (cons
      predicate
      (apply
       append
       (reverse fields)))))

  (define named-fields
    (map (lambda (field-name field) (cons field-name field))
         field-names fields))
  (type9-register-descriptor! name constructor predicate mutable? named-fields)

  (apply values ret))

(define-syntax define-type9-helper
  (syntax-rules ()
    ((_ buf body constructor-name predicate-name)
     (define-values (constructor-name predicate-name . buf) body))
    ((_ buf body constructor-name predicate-name (field-name field-accessor) . field-specs)
     (define-type9-helper (field-accessor . buf) body constructor-name predicate-name . field-specs))
    ((_ buf body constructor-name predicate-name (field-name field-accessor field-setter) . field-specs)
     (define-type9-helper (field-accessor field-setter . buf) body constructor-name predicate-name . field-specs))
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
       constructor-name predicate-name . field-specs))))
