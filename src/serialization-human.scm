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

%use (builtin-type?) "./builtin-type-huh.scm"
%use (debugv) "./debugv.scm"
%use (type9-get-record-descriptor) "./define-type9.scm"
%use (raisu) "./raisu.scm"
%use (serialize-builtin/natural) "./serialization-builtin-natural.scm"

(define (serialize-type9-fields obj descriptor loop)
  (define fields (cdr (assoc 'fields descriptor)))
  (debugv fields)
  (define accessors
    (map (lambda (field) (list-ref field 1)) fields))
  (map (lambda (a) (loop (a obj))) accessors))

(define (serialize/human o)
  (let loop ((o o))
    (if (builtin-type? o)
        (serialize-builtin/natural o loop)
        (let ((r9d (type9-get-record-descriptor o)))
          (if r9d
              (let ()
                (debugv r9d)
                (cons (cdr (assoc 'name r9d))
                      (serialize-type9-fields o r9d loop)))
              (raisu 'unknown-type o))))))

(define (deserialize/human obj)
  obj)
