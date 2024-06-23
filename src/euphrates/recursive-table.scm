;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-syntax recursive-table/row
  (syntax-rules (! +)
    ((_ self buf ! + . vals)
     (cons
      (reverse buf)
      (recursive-table/scan self + . vals)))
    ((_ self buf ! x . vals)
     (recursive-table/row
      self
      (cons
       (memconst
        (parameterize ((recursive-table/self/p self))
          (let () x)))
       buf)
      . vals))))

(define-syntax recursive-table/scan
  (syntax-rules (! +)
    ((_ self + ---- +) (list))
    ((_ self + ---- + ! . vals)
     (recursive-table/row self (list) ! . vals))))

(define-syntax recursive-table
  (syntax-rules ()
    ((_ . args)
     (let ()
       (define self
         (recursive-table/scan self . args))

       (define valued-self
         (map (lambda (row)
                (map (lambda (thunk) (thunk)) row))
              self))

       valued-self))))
