;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:to-minimal-dnf/assuming-nointersect exported-names/set model)
  (appcomp model
           labelinglogic:model:inline-all
           (labelinglogic:model:reduce-to-names/unsafe exported-names/set)
           labelinglogic:model:optimize/assuming-nointersect
           labelinglogic:model:latticize-ands-assuming-nointersect-dnf
           labelinglogic:model:inline-all
           (labelinglogic:model:reduce-to-names/unsafe exported-names/set)
           labelinglogic:model:optimize/or/just-idempotency
           labelinglogic:model:deduplicate-subexpressions
           labelinglogic:model:factor-dnf-clauses
           labelinglogic:model:inline-dnf-clauses
           (labelinglogic:model:reduce-to-names exported-names/set)))
