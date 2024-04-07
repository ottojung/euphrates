;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:reachable-from names/stack model)
  (define ret (list->hashset (stack->list names/stack)))
  (define stack (stack-copy names/stack))

  (let loop ()
    (unless (stack-empty? stack)
      (let ()
        (define current (stack-pop! stack))

        (define expr
          (labelinglogic:model:assoc
           current model))

        (define constants
          (labelinglogic:expression:constants expr))

        (for-each
         (lambda (c)
           (unless (hashset-has? ret c)
             (hashset-add! ret c)
             (stack-push! stack c)))
         constants)

        (loop))))

  ret)
