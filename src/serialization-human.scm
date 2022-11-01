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
%use (builtin-type?) "./builtin-type-huh.scm"
%use (type9-get-record-descriptor) "./define-type9.scm"
%use (descriptors-registry-get) "./descriptors-registry.scm"
%use (raisu) "./raisu.scm"
%use (deserialize-builtin/natural serialize-builtin/natural) "./serialization-builtin-natural.scm"

(define (serialize-type9-fields obj descriptor loop)
  (define fields (assoc-or 'fields descriptor (raisu 'no-fields-in-descriptor descriptor obj)))
  (define accessors
    (map (lambda (field) (list-ref field 1)) fields))
  (map (lambda (a) (loop (a obj))) accessors))

(define (serialize/human o)
  (let loop ((o o))
    (if (builtin-type? o)
        (serialize-builtin/natural o loop)
        (let ((r9d (type9-get-record-descriptor o)))
          (if r9d
              (cons (cdr (assoc 'name r9d))
                    (serialize-type9-fields o r9d loop))
              (raisu 'unknown-type o))))))

(define (deserialize/human o)
  (let loop ((o o))
    (deserialize-builtin/natural
     o loop
     (let ()
       (when (or (not (list? o))
                 (null? o))
         (raisu 'bad-format:expecting-list o))
       (let ((name (car o))
             (args (cdr o)))
         (let ((r9d (or (descriptors-registry-get name)
                        (raisu 'unkown-type-tag name))))
           (define constructor (assoc-or 'constructor r9d (raisu 'no-constructor-in-descriptor r9d)))
           (apply constructor (map loop args))))))))
