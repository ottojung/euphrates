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
%use (raisu) "./raisu.scm"
%use (deserialize/sexp/natural serialize/sexp/natural) "./serialization-sexp-natural.scm"

(define (serialize-type9-fields obj descriptor loop)
  (define fields (assoc-or 'fields descriptor (raisu 'no-fields-in-descriptor descriptor obj)))
  (define accessors
    (map (lambda (field) (list-ref field 1)) fields))
  (map (lambda (a) (loop (a obj))) accessors))

(define serialize/runnable
  (serialize/sexp/natural
   serialize-type9-fields
   (lambda (o)
     (cons 'procedure o))))

(define (deserialize-type9-fields obj descriptor loop)
  (map loop (cdr obj)))

(define deserialize/runnable
  (deserialize/sexp/natural
   deserialize-type9-fields
   (lambda (o)
     (and (equal? 'procedure (car o))
          (cdr o)))))
