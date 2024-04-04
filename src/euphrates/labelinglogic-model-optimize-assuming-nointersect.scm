;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:optimize/assuming-nointersect exported-names/set model)
  (define _91273 (labelinglogic:model:check model))

  (define extended-model
    (labelinglogic:model:append model bindings))

  (define inlined-model
    (labelinglogic:model:inline-all extended-model))

  (define bindings-model
    (labelinglogic:model:reduce-to-bindings inlined-model bindings))

  (define opt-dnf-model
    (labelinglogic:model:optimize/assuming-nointersect bindings-model))

  (define latticised
    (labelinglogic:model:latticize-ands-assuming-nointersect-dnf opt-dnf-model))

  (define latticised-inlined
    (labelinglogic:model:inline-all latticised))

  (define latticised-reduced
    (labelinglogic:model:reduce-to-bindings latticised-inlined bindings))

  (define latticised-opt
    (labelinglogic:model:optimize/or/just-idempotency latticised-reduced))

  (define ret-model
    latticised-opt)

  ret-model)
