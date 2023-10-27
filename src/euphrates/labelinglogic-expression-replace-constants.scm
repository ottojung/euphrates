;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:replace-constants replacer-fun expr)
  (define memory (make-hashmap))
  (define default-key (make-unique))

  (define (cached-replacer constant)
    (define existing
      (hashmap-ref memory constant default-key))

    (if (equal? existing default-key)
        (let ()
          (define new (replacer-fun constant))
          (labelinglogic:expression:check new)
          (hashmap-set! memory constant new)
          new)
        existing))

  (let loop ((expr expr))
    (define type
      (labelinglogic:expression:type expr))

    (define args
      (labelinglogic:expression:args expr))

    (cond
     ((equal? 'constant type) (cached-replacer expr))
     ((equal? '= type) expr)
     ((equal? 'r7rs type) expr)
     (else
      (labelinglogic:expression:make
       type (map loop args))))))
