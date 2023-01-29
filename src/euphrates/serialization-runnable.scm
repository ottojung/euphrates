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

%var serialize/runnable
%var deserialize/runnable

%use (assoc-or) "./assoc-or.scm"
%use (descriptors-registry-get) "./descriptors-registry.scm"
%use (raisu) "./raisu.scm"
%use (deserialize/sexp/natural serialize/sexp/natural) "./serialization-sexp-natural.scm"

(define (serialize-type9-fields obj r9d loop)
  (define fields (assoc-or 'fields r9d (raisu 'no-fields-in-r9d r9d obj)))
  (define name (cdr (assoc 'name r9d)))
  (define accessors
    (map (lambda (field) (list-ref field 1)) fields))
  (cons name
        (map (lambda (a) (loop (a obj))) accessors)))

(define serialize/runnable
  (serialize/sexp/natural
   serialize-type9-fields
   (lambda (o)
     (cons 'procedure o))))

(define (deserialize-type9-fields/runnable obj descriptor loop)
  (map loop (cdr obj)))

(define (deserialize-type9/runnable o loop)
  (when (or (not (list? o))
            (null? o))
    (raisu 'bad-format:expecting-list o))

  (let* ((name (car o)))
    (define r9d (or (descriptors-registry-get name)
                    (raisu 'unkown-type-tag name)))
    (define constructor (assoc-or 'constructor r9d (raisu 'no-constructor-in-descriptor r9d)))
    (define args (deserialize-type9-fields/runnable o r9d loop))
    (apply constructor args)))

(define deserialize/runnable
  (deserialize/sexp/natural
   deserialize-type9/runnable
   (lambda (o)
     (and (equal? 'procedure (car o))
          (cdr o)))))
