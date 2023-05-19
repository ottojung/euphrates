;;;; Copyright (C) 2023  Otto Jung
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

(cond-expand
 (guile
  (define-module (euphrates cfg-remove-dead-code)
    :export (CFG-remove-dead-code)
    :use-module ((euphrates cfg-strip-modifiers) :select (CFG-strip-modifiers))
    :use-module ((euphrates hashmap) :select (alist->hashmap))
    :use-module ((euphrates hashset) :select (hashset-add! hashset-has? make-hashset))
    )))

(define (CFG-remove-dead-code CFG)
  (if (null? CFG) CFG
      (let ()
        (define main-production (car CFG))
        (define hashed (alist->hashmap CFG))
        (define reachable (make-hashset))

        (let loop ((current main-production))
          (define name (car current))
          (define regex (cdr current))

          (hashset-add! reachable name)

          (for-each
           (lambda (alternative)
             (for-each
              (lambda (atom)
                (define name-pure
                  (string->symbol
                   (CFG-strip-modifiers atom)))
                (hashset-add! reachable name-pure))
              alternative))
           regex))

        (filter
         (lambda (production)
           (define name (car production))
           (define regex (cdr production))
           (hashset-has? reachable name))
         CFG))))
