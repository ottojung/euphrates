;;;; Copyright (C) 2021  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

%var petri-net-obj
%var petri-net-obj?
%var petri-net-obj-transitions
%var petri-net-obj-queue
%var petri-net-obj-critical
%var petri-net-obj-finished?
%var set-petri-net-obj-finished?!

%use (define-type9) "./define-type9.scm"

(define-type9 <petri-net-obj>
  (petri-net-obj transitions queue critical finished?) petri-net-obj?
  (transitions petri-net-obj-transitions)
  (queue petri-net-obj-queue)
  (critical petri-net-obj-critical)
  (finished? petri-net-obj-finished? set-petri-net-obj-finished?!)
  )
