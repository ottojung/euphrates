;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; Returns list of all symbols that can emminate from a given `state`.
;;
(define (parselynn:lr-state:next-symbols state)
  (define ret
    (make-hashset))

  (parselynn:lr-state:foreach-item

   (lambda (item)
     (unless (parselynn:lr-item:dot-at-end? item)
       (let ()
         (define next-symbol (parselynn:lr-item:next-symbol item))
         (hashset-add! ret next-symbol))))

   state)

  (euphrates:list-sort
   (hashset->list ret)
   (lambda (a b)
     (string<? (~s a) (~s b)))))
