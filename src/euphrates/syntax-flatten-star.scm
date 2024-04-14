;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Fully flattens syntax tree, so that ((a b (c (g h) d) (h) e)) becomes (a b c g h d h e)


(define-syntax syntax-flatten*-aux
  (syntax-rules ()
    [(_ cont ((xs ...) ys ...) (result ...))
     (syntax-flatten*-aux cont (xs ... ys ...) (result ...))]
    [(_ cont (x xs ...) (result ...))
     (syntax-flatten*-aux cont (xs ...) (x result ...))]
    [(_ cont () (result ...))
     (syntax-reverse cont (result ...))]))

(define-syntax syntax-flatten*
  (syntax-rules ()
    ((_ cont xs)
     (syntax-flatten*-aux cont xs ()))))
