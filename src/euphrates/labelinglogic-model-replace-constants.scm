;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:replace-constants model replacer-fun)
  (define memory (make-hashmap))
  (define default-key (make-unique))

  (define (cached-replacer constant)
    (define existing
      (hashmap-ref memory constant default-key))

    (if (equal? existing default-key)
        (let ()
          (define new (replacer-fun constant))
          (hashmap-set! memory constant new)
          new)
        existing))

  (map
   (lambda (model-component)
     (define-tuple (class predicate) model-component)
     (list (cached-replacer class)
           (labelinglogic:expression:replace-constants
            predicate cached-replacer)))
   model))
