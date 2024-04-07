;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn-singlechar-model
  (let ()
    (define nocase?
      '(lambda (c)
         (and (char? c)
              (char-alphabetic? c)
              (not (char-upper-case? c))
              (not (char-lower-case? c)))))

    (define upper-case?
      `(lambda (c)
         (and (char? c)
              (char-alphabetic? c)
              (char-upper-case? c))))

    (define lower-case?
      `(lambda (c)
         (and (char? c)
              (char-alphabetic? c)
              (char-lower-case? c))))

    (define numeric?
      `(lambda (c)
         (and (char? c)
              (char-numeric? c))))

    (define whitespace?
      `(lambda (c)
         (and (char? c)
              (char-whitespace? c))))

    (define special?
      `(lambda (c)
         (and (char? c)
              (not (char-alphabetic? c))
              (not (char-numeric? c))
              (not (char-whitespace? c)))))

    (define model
      `((any (or alphanum whitespace special))
        (alphanum (or numeric alphabetic))
        (alphabetic (or upcase lowercase nocase))
        (upcase (r7rs ,upper-case?))
        (lowercase (r7rs ,lower-case?))
        (nocase (r7rs ,nocase?))
        (numeric (r7rs ,numeric?))
        (whitespace (r7rs ,whitespace?))
        (special (r7rs ,special?))
        ))

    model))
