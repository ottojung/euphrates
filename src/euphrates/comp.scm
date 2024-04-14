;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; `comp` operator from clojure
(define-syntax %comp-helper
  (syntax-rules ()
    ((_ buf ())
     (compose . buf))
    ((_ buf ((x . xs) . y))
     (%comp-helper ((partial-apply1 x . xs) . buf) y))
    ((_ buf (x . y))
     (%comp-helper (x . buf) y))))

(define-syntax comp
  (syntax-rules ()
    ((_ . xs)
     (%comp-helper () xs))))

;; thread (->>) operator from clojure
(define-syntax appcomp
  (syntax-rules ()
    ((_ x . xs)
     ((comp . xs) x))))
