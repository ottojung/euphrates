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

%use (alpha-lowercase/alphabet) "./euphrates/alpha-lowercase-alphabet.scm"
%use (list-take-n) "./euphrates/list-take-n.scm"
%use (printf) "./euphrates/printf.scm"
%use (range) "./euphrates/range.scm"
%use (~a) "./euphrates/tilda-a.scm"
%use (words->string) "./euphrates/words-to-string.scm"

(define N 3)

(define (get-field-names n)
  (map
   string
   (list-take-n
    n (vector->list alpha-lowercase/alphabet))))

(define all-fields (get-field-names N))

(define (print-definition n mutable?)
  (define fields (get-field-names n))
  (define ns (if mutable? (string-append (~a n) "m") n))
  (printf "(define-type9 r~a" ns)
  (newline)
  (printf "  (r~a-constructor id" ns)
  (unless (null? fields)
    (printf " ~a" (words->string fields)))
  (printf ") r~a-predicate" ns)
  (newline)
  (printf "  (id r~a-id-accessor)" ns)

  (for-each
   (lambda (field)
     (newline)
     (printf "  (~a r~a-~a-field-accessor" field ns field)
     (when mutable?
       (printf " r~a-~a-field-setter" ns field field))
     (printf ")"))
   fields)

  (printf ")")
  (newline)
  )

(define (print-definitions)
  (for-each
   (lambda (n)
     (print-definition n #f)
     (newline)
     (print-definition n #t)
     (newline)
     )
   (range (+ 1 N))))

(define (print-vector1/g field mutable?)
  (printf "(define type8-~amutable-~as"
          (if mutable? "" "im")
          field)
  (newline)
  (printf "  (vector")
  (for-each
   (lambda (n)
     (printf " r~a-~a" n field))
   (range (+ 1 N)))
  (printf "))")
  (newline))

(define (print-vector1 field)
  (print-vector1/g field #f)
  (newline)
  (print-vector1/g field #t)
  (newline))

(define (print-constructors)
  (print-vector1 "constructor"))

(define (print-predicates)
  (print-vector1 "predicate"))

(define (print-vector2/g field mutable?)
  (printf "(define type8-~amutable-~as"
          (if mutable? "" "im")
          field)
  (newline)
  (printf "  (vector")
  (for-each
   (lambda (n)
     (define ns (if mutable? (string-append (~a n) "m") n))
     (newline)
     (printf "    (vector")
     (for-each
      (lambda (k)
        (printf " r~a-~a-field-~a"
                ns (list-ref all-fields k) field))
      (range n))
     (printf ")")
     )
   (range (+ 1 N)))
  (printf "))")
  (newline))

(define (print-accessors)
  (print-vector2/g "accessor" #f)
  (newline)
  (print-vector2/g "accessor" #t)
  (newline))

(define (print-setters)
  (print-vector2/g "setter" #t)
  (newline))

(newline)
(print-definitions)
(print-constructors)
(print-predicates)
(print-accessors)
(print-setters)
(newline)
