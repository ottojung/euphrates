;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (parselynn:lr-make-initial-state bnf-alist)
  (define first-set
    (bnf-alist:compute-first-set bnf-alist))

  (parselynn:lr-make-initial-state/given-first
   first-set bnf-alist))


(define (parselynn:lr-make-initial-state/given-first first-set bnf-alist)
  (define state (parselynn:lr-state:make))
  (define first-production (bnf-alist:start-symbol bnf-alist))

  (parselynn:lr-state:add!
   state
   (parselynn:lr-item:make
    parselynn:start-symbol
    (list first-production)
    parselynn:end-of-input))

  (parselynn:lr-state:close!/given-first
   first-set bnf-alist state)

  state)
