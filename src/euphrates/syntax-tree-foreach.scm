;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax syntax-tree-foreach
  (syntax-rules ()
    [(_ f ((xs ...) ys ...))
     (begin (syntax-tree-foreach f (xs ...))
            (syntax-tree-foreach f (ys ...)))]
    [(_ f (x xs ...))
     (begin (f x)
            (syntax-tree-foreach f (xs ...)))]
    [(_ f ())
     (begin)]))

;; Example:
;; (define-syntax defn
;;   (syntax-rules ()
;;     ((_ m)
;;      (define m #f))))
;; (syntax-tree-foreach defn (a (b (c d)) e)) ;; declares all identifiers
