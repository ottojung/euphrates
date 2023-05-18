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
  (define-module (euphrates cfg-inline)
    :export (CFG-inline)
    :use-module ((euphrates cfg-parse-modifiers) :select (CFG-parse-modifiers))
    :use-module ((euphrates comp) :select (comp))
    :use-module ((euphrates hashmap) :select (alist->hashmap hashmap-ref))
    :use-module ((euphrates list-map-flatten) :select (list-map/flatten))
    :use-module ((euphrates list-singleton-q) :select (list-singleton?))
    )))


(define (CFG-inline CFG)
  (define hashed
    (alist->hashmap CFG))

  (define (noalternative? production)
    (define name (car production))
    (define regex (cdr production))
    (list-singleton? regex))

  (define (constant? production)
    (and (noalternative? production)
         (let ((name (car production))
               (regex (cdr production)))
           (let ((first-choice (car regex)))
             (list-singleton? first-choice)))))

  (define (do-inline name)
    (define-values (name/pure/s modifiers/s)
      (CFG-parse-modifiers name))
    (define name/pure (string->symbol name/pure/s))
    (define regex (hashmap-ref hashed name/pure #f))
    (and regex
         (let ((production (cons name regex)))
           (cond
            ((constant? production)
             (let ()
               (define c (car (car regex)))
               (define-values (c-pure c-modifiers)
                 (CFG-parse-modifiers c))

               (and (string-null? c-modifiers)
                    (list
                     (string->symbol
                      (string-append c-pure modifiers/s))))))
            ((noalternative? production)
             (and (string-null? modifiers/s)
                  (car regex)))
            (else #f)))))

  (define (inline/flat name)
    (or (do-inline name) (list name)))

  (define inlined
    (map
     (lambda (production)
       (define name (car production))
       (define regex (cdr production))
       (cons name (map (comp (list-map/flatten inline/flat)) regex)))
     CFG))

  inlined)

