;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; This is a FAKE action.
;; It is actually never present in the parsing table.
;; Instead it is used to signal conflicts.
;; It represents a choice of the interpreter when it decides between
;; the candidates created from FIRST and FOLLOW sets.
;;

(define-type9 <choose>
  (parselynn:ll-choose-action:make production)

  parselynn:ll-choose-action?

  (production parselynn:ll-choose-action:production)

  )
