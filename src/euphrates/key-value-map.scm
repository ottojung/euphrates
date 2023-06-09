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
  (define-module (euphrates key-value-map)
    :export (key-value-map key-value-map/list))))


(define-syntax key-value-map/list
  (syntax-rules (! +)
    ((_ + ---- +) (list))
    ((_ + ---- + ! key ! value ! . rest)
     (cons
      (cons (quote key) value)
      (key-value-map/list . rest)))))

(define-syntax key-value-map
  (syntax-rules (! +)
    ((_ . args)
     (alist->hashmap
      (parse-key-value-map/list . args)))))

