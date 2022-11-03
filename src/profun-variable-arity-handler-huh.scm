;;;; Copyright (C) 2022  Otto Jung
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

%var profun-variable-arity-handler?

%use (profun-handler-arity) "./profun-handler-obj.scm"
%use (profun-variable-arity-handler-keyword) "./profun-variable-arity-handler-keyword.scm"

(define (profun-variable-arity-handler? handler)
  (equal? (profun-handler-arity handler)
          profun-variable-arity-handler-keyword))
