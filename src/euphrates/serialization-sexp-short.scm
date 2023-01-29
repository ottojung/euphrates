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

%var serialize/sexp/short
%var deserialize/sexp/short

%use (deserialize-builtin/short serialize-builtin/short) "./serialization-builtin-short.scm"
%use (deserialize/sexp/generic serialize/sexp/generic) "./serialization-sexp-generic.scm"

(define (serialize/sexp/short serialize-type9-fields procedure-serialization)
  (serialize/sexp/generic serialize-type9-fields procedure-serialization serialize-builtin/short))

(define (deserialize/sexp/short deserialize-type9-fields procedure-deserialization)
  (deserialize/sexp/generic deserialize-type9-fields procedure-deserialization deserialize-builtin/short))
