;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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

%var monad-log

%use (dprint) "./dprint.scm"
%use (monadstate-args) "./monadstate.scm"
%use (monadstateobj-qval monadstateobj-qvar) "./monadstateobj.scm"
%use (monadfin?) "./monadfin.scm"
%use (~a) "./tilda-a.scm"
%use (words->string) "./words-to-string.scm"

(define (monad-log-show-values monad-input)
  (words->string (map ~a (monadstate-args monad-input))))

(define monad-log
  (lambda (monad-input)
    (if (monadfin? monad-input)
        (dprint "(return ~a)\n" (monad-log-show-values monad-input))
        (dprint "(~a = ~a = ~a)\n"
                (monadstateobj-qvar monad-input)
                (monad-log-show-values monad-input)
                (monadstateobj-qval monad-input)))
    monad-input))
