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




(define (serialize/sexp/generic serialize-type9 procedure-serialization builtin-serialization)
  (lambda (o)
    (let loop ((o o))
      (cond
       ((procedure? o)
        (procedure-serialization o))
       ((builtin-type? o)
        (builtin-serialization o loop))
       (else
        (let ((r9d (type9-get-record-descriptor o)))
          (if r9d
              (serialize-type9 o r9d loop)
              (raisu 'unknown-type o))))))))

(define (deserialize/sexp/generic deserialize-type9 procedure-serialization builtin-deserialization)
  (lambda (o)
    (let loop ((o o))
      (builtin-deserialization
       o loop
       (lambda _
         (or (procedure-serialization o)
             (deserialize-type9 o loop)))))))
