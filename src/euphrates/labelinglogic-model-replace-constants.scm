;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:replace-constants replacer-fun model)
  (define memory (make-hashmap))
  (define default-key (make-unique))

  (define (cached-replacer class predicate)
    (define fun (replacer-fun class))
    (lambda (constant)
      (define existing
        (hashmap-ref memory constant default-key))

      (if (equal? existing default-key)
          (let ()
            (define new (fun constant))
            (labelinglogic:expression:check new)
            (hashmap-set! memory constant new)
            new)
          existing)))

  (labelinglogic:model:map-expressions
   (lambda (class predicate)
     (define replacer (cached-replacer class predicate))
     (lambda (expr)
       (labelinglogic:expression:replace-constants
        replacer expr)))
   model))
