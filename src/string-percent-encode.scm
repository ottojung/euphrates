;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
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

%run guile

%var string-percent-encode
%var string-percent-encode/generic

%use (alphanum/alphabet alphanum/alphabet/index) "./alphanum-alphabet.scm"
%use (convert-number-base/generic) "./convert-number-base.scm"

(define (string-percent-encode/generic s alphabet in-alphabet? percent-char)
  (define len (string-length s))
  (define counter 0)

  (if (string-index s (negate in-alphabet?))
      (call-with-output-string
       (lambda (port)
         (string-for-each
          (lambda (ch)
            (set! counter (+ 1 counter))
            (if (in-alphabet? ch)
                (display ch port)
                (begin
                  (display percent-char port)
                  (display
                   (list->string
                    (convert-number-base/generic
                     alphabet
                     (vector-length alphabet)
                     (char->integer ch)))
                   port)
                  (unless (= len counter)
                    (display percent-char port)))))
          s)))
      s))

(define (string-percent-encode s)
  (string-percent-encode/generic s alphanum/alphabet alphanum/alphabet/index #\%))
