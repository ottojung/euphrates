;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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

%var profun-state-constructor
%var profun-state?
%var profun-state-current
%var profun-state-stack
%var profun-state-failstate
%var profun-state-undo

%use (define-type9) "./define-type9.scm"

(define-type9 <profun-state>
  (profun-state-constructor current stack failstate undo) profun-state?
  (current profun-state-current) ;; current `profun-instruction`
  (stack profun-state-stack) ;; list of `profun-instruction`s
  (failstate profun-state-failstate) ;; `state` to go to if this `state` fails. Initially #f
  (undo profun-state-undo) ;; commands to run when backtracking to `failstate'. Initially '()
  )
