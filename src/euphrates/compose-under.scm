;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax compose-under-cont
  (syntax-rules ()
    ((_ op buf) (op . buf))))

(define-syntax compose-under-helper
  (syntax-rules ()
    [(_ args op buf ())
     (lambda args
       (syntax-reverse (compose-under-cont op) buf))]
    [(_ args op buf (f . fs))
     (compose-under-helper
      args op
      ((apply f args) . buf)
      fs)]))

(define-syntax compose-under
  (syntax-rules ()
    ((_ operation . composites)
     (compose-under-helper args operation () composites))))
