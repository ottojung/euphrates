;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (gkeyword? x)
  (or (fkeyword? x) (rkeyword? x)))

(define (gkeyword->fkeyword x)
  (if (fkeyword? x) x
      (string->symbol
       (string-append
        (let ((s (symbol->string x)))
          (substring s 1))
        ":"))))

(define (gkeyword->rkeyword x)
  (if (rkeyword? x) x
      (string->symbol
       (string-append
        ":" (let ()
              (define s (symbol->string x))
              (define n (string-length s))
              (substring s 0 (- n 1)))))))
