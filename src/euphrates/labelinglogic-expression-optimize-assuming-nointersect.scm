;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/assuming-nointersect expr)
  (define (optimize/singletons expr)
    (define args (labelinglogic:expression:args expr))
    (if (list-singleton? args)
        (car args)
        expr))

  (define dnf
    (labelinglogic:expression:to-dnf expr))

  (define dnf-type
    (labelinglogic:expression:type dnf))
  (define dnf-args
    (labelinglogic:expression:args dnf))

  (define dnf*
    (if (equal? 'or dnf-type)
        (labelinglogic:expression:make
         dnf-type (list-deduplicate dnf-args))
        dnf))

  (define dnf*-args
    (labelinglogic:expression:args dnf*))

  (define simpl
    (map labelinglogic:expression:optimize/and-assuming-nointersect
         dnf*-args))

  (define simpl-type
    (labelinglogic:expression:type simpl))
  (define simpl-args
    (labelinglogic:expression:args simpl))

  (define simpl*
    (if (equal? 'or simpl-type)
        (labelinglogic:expression:make
         simpl-type (list-deduplicate simpl-args))
        simpl))

  simpl*)
