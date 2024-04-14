;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax syntax-map/noeval/buf
  (syntax-rules ()
    ((_ cont buf fun) (syntax-reverse cont buf))
    ((_ cont buf (fun ctxarg) x . xs) (syntax-map/noeval/buf cont ((fun ctxarg x) . buf) (fun ctxarg) . xs))
    ((_ cont buf fun x . xs) (syntax-map/noeval/buf cont ((fun x) . buf) fun . xs))))

(define-syntax syntax-map/noeval
  (syntax-rules ()
    ((_ cont fun args-to-map)
     (syntax-map/noeval/buf cont () fun . args-to-map))))
