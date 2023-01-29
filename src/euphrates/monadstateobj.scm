;;;; Copyright (C) 2022  Otto Jung
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

%var monadstateobj
%var monadstateobj?
%var monadstateobj-lval
%var monadstateobj-cont
%var monadstateobj-qvar
%var monadstateobj-qval
%var monadstateobj-qtags

%use (define-type9) "./define-type9.scm"

(define-type9 <monadstateobj>
  (monadstateobj lval cont qvar qval qtags) monadstateobj?
  (lval monadstateobj-lval)
  (cont monadstateobj-cont)
  (qvar monadstateobj-qvar)
  (qval monadstateobj-qval)
  (qtags monadstateobj-qtags))
