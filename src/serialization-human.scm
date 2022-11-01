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

%var serialize/human
%var deserialize/human

%use (assoc-or) "./assoc-or.scm"
%use (raisu) "./raisu.scm"
%use (deserialize/sexp/generic serialize/sexp/generic) "./serialization-sexp-generic.scm"

(define (serialize-type9-fields obj descriptor loop)
  (define fields (assoc-or 'fields descriptor (raisu 'no-fields-in-descriptor descriptor obj)))
  (map (lambda (field)
         (define name (list-ref field 0))
         (define accessor (list-ref field 1))
         (list name (loop (accessor obj)))) fields))

(define serialize/human
  (serialize/sexp/generic serialize-type9-fields))

(define (deserialize-type9-fields obj descriptor loop)
  (define fields (assoc-or 'fields descriptor (raisu 'no-fields-in-descriptor descriptor obj)))
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

(define deserialize/human
  (deserialize/sexp/generic deserialize-type9-fields))
