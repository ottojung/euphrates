;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax syntax-append/buf
  (syntax-rules ()
    ((_ cont buf () ()) (syntax-reverse cont buf))
    ((_ cont buf (a . as) bs)
     (syntax-append/buf cont (a . buf) as bs))
    ((_ cont buf as (b . bs))
     (syntax-append/buf cont (b . buf) as bs))))

(define-syntax syntax-append/cont
  (syntax-rules ()
    ((_ (cont a) b)
     (syntax-append cont a b))))

(define-syntax syntax-append
  (syntax-rules ()
    ((_ cont a b) (syntax-append/buf cont () a b))
    ((_ cont a b . bs)
     (syntax-append (syntax-append/cont (cont a)) b . bs))))
