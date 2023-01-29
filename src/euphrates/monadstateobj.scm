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

(cond-expand
 (guile
  (define-module (euphrates monadstateobj)
    :export (monadstateobj monadstateobj? monadstateobj-lval monadstateobj-cont monadstateobj-qvar monadstateobj-qval monadstateobj-qtags)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <monadstateobj>
  (monadstateobj lval cont qvar qval qtags) monadstateobj?
  (lval monadstateobj-lval)
  (cont monadstateobj-cont)
  (qvar monadstateobj-qvar)
  (qval monadstateobj-qval)
  (qtags monadstateobj-qtags))
