;;;; Copyright (C) 2023  Otto Jung
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
  (define-module (euphrates asyncproc-input-text-p)
    :export (asyncproc-input-text/p)
    :use-module ((euphrates assoc-or) :select (assoc-or))
    :use-module ((euphrates descriptors-registry) :select (descriptors-registry-get))
    :use-module ((euphrates raisu) :select (raisu))
    :use-module ((euphrates serialization-sexp-natural) :select (deserialize/sexp/natural serialize/sexp/natural)))))

(define asyncproc-input-text/p
  (make-parameter #f))
