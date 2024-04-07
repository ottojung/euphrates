;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:to-minimal-dnf/assuming-nointersect exported-names/set model)
  (define inlined-model
    (labelinglogic:model:inline-all model))

  (define bindings-model
    (labelinglogic:model:reduce-to-names/unsafe exported-names/set inlined-model))

  (define opt-dnf-model
    (labelinglogic:model:optimize/assuming-nointersect bindings-model))

  (define latticised
    (labelinglogic:model:latticize-ands-assuming-nointersect-dnf opt-dnf-model))

  (define latticised-inlined
    (labelinglogic:model:inline-all latticised))

  (define latticised-reduced
    (labelinglogic:model:reduce-to-names/unsafe exported-names/set latticised-inlined))

  (define latticised-opt
    (labelinglogic:model:optimize/or/just-idempotency latticised-reduced))

  (define dedup-model
    (labelinglogic:model:deduplicate-subexpressions latticised-opt))

  (define factored-model
    (labelinglogic:model:factor-dnf-clauses dedup-model))

  (debugs factored-model)

  (define inlined-model-2
    (labelinglogic:model:inline-dnf-clauses factored-model))

  (debugs inlined-model-model)

  (define reduced-model
    (labelinglogic:model:reduce-to-names exported-names/set inlined-model-2))

  reduced-model)
