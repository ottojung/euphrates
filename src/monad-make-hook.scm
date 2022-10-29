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

%var monad-make/hook

%use (monadstate-args) "./monadstate.scm"
%use (monadfin?) "./monadfin.scm"

(define-syntax monad-make/hook
  (syntax-rules ()
    ((_ args . bodies)
     (lambda (monad-input)
       (if (monadfin? monad-input) monad-input
           (apply (lambda args . bodies)
                  (monadstate-args monad-input)))))))
