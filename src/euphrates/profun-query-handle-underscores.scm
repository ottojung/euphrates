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

(cond-expand
 (guile
  (define-module (euphrates profun-query-handle-underscores)
    :export (profun-query-handle-underscores)
    :use-module ((euphrates list-and-map) :select (list-and-map))
    :use-module ((euphrates usymbol) :select (make-usymbol)))))



(define (profun-query-handle-underscores query)
  (define (handle-elem x)
    (if (symbol? x)
        (let ((s (symbol->string x)))
          (if (string-prefix? "_" s)
              (if (= 1 (string-length s))
                  (make-usymbol x (cons 'u (gensym)))
                  (make-usymbol x 'u))
              x))
        x))

  (define (handle-expr expr)
    (map handle-elem expr))

  (cond
   ((not (list? query)) 'bad-query:not-a-list)
   ((not (list-and-map list? query)) 'bad-query:expr-not-a-list)
   (else (map handle-expr query))))
