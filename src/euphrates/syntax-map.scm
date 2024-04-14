;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax syntax-map/buf/cont
  (syntax-rules ()
    ((_ (cont buf fun xs) funx)
     (syntax-map/buf cont (funx . buf) fun . xs))))

(define-syntax syntax-map/buf
  (syntax-rules ()
    ((_ cont buf fun) (syntax-reverse cont buf))
    ((_ cont buf (fun ctxarg) x . xs)
     (fun (syntax-map/buf/cont (cont buf (fun ctxarg) xs))
          ctxarg
          x))
    ((_ cont buf fun x . xs)
     (fun (syntax-map/buf/cont (cont buf fun xs))
          x))))

(define-syntax syntax-map
  (syntax-rules ()
    ((_ cont fun args-to-map)
     (syntax-map/buf cont () fun . args-to-map))))
