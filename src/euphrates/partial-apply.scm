;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax partial-apply-helper
  (syntax-rules ()
    ((_ f buf () last) (apply f (reversed-args-f cons* last . buf)))
    ((_ f buf (a . args) last)
     (partial-apply-helper f (a . buf) args last))))

(define-syntax partial-apply
  (syntax-rules ()
    ((_ f . args)
     (lambda xs
       (partial-apply-helper f () args xs)))))
