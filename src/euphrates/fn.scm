;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax fn%-replace1
  (syntax-rules (%)
    ((_ cont arg-name (x . xs)) (syntax-map cont (fn%-replace1 arg-name) (x . xs)))
    ((_ (cont ctxarg) arg-name %) (cont ctxarg arg-name))
    ((_ cont arg-name %) (cont arg-name))
    ((_ (cont ctxarg) arg-name expr) (cont ctxarg expr))
    ((_ cont arg-name expr) (cont expr))))

;; Makes 1-argument lambda with a hole marked by "%".
;; Works even if "%" is deeply nested.
(define-syntax fn
  (syntax-rules ()
    ((_ . args)
     (lambda (arg-name)
       (fn%-replace1 syntax-identity arg-name args)))))
