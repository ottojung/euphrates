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

(cond-expand
 (guile
  (define-module (euphrates string-plus-encode)
    :export (string-plus-encode string-plus-encode/generic string-plus-encoding-make)
    :use-module ((euphrates alphanum-alphabet) :select (alphanum/alphabet alphanum/alphabet/index))
    :use-module ((euphrates convert-number-base) :select (convert-number-base/generic)))))



;; NOTE: this is like the uri-encoding, but compresses better.
(define-values (string-plus-encode/generic string-plus-encode string-plus-encoding-make)
  (let ()
    (define (generic s alphabet in-alphabet? maxcode open-char)
      (define len (string-length s))
      (define alen (vector-length alphabet))
      (define last-opened? #f)
      (define close-sequence
        (string open-char (vector-ref alphabet 0)))

      (if (string-index s (negate in-alphabet?))
          (call-with-output-string
           (lambda (port)
             (string-for-each
              (lambda (ch)
                (if (in-alphabet? ch)
                    (begin
                      (when last-opened?
                        (set! last-opened? #f)
                        (display close-sequence port))
                      (display ch port))
                    (begin
                      (set! last-opened? #t)
                      (display open-char port)
                      (display
                       (list->string
                        (convert-number-base/generic
                         alphabet alen
                         (tointeger alphabet alen maxcode ch)))
                       port))))
              s)))
          s))

    (define (get-alphabet-maxcode alphabet)
      (let loop ((m 0) (i (- (vector-length alphabet) 1)))
        (if (< i 0) m
            (loop
             (let* ((c (vector-ref alphabet i))
                    (code (char->integer c)))
               (max code m))
             (- i 1)))))

    (define (tointeger alphabet alen maxcode ch)
      (define code (+ 1 (char->integer ch)))
      (cond
       ((<= code maxcode) code)
       ((<= code (+ maxcode alen))
        (char->integer (vector-ref alphabet (- code maxcode 1))))
       (else (- code alen))))

    (define (make alphabet in-alphabet? open-char)
      (define maxcode (get-alphabet-maxcode alphabet))
      (lambda (s)
        (generic s alphabet in-alphabet? maxcode open-char)))

    (define default-alphabet alphanum/alphabet)
    (define default-alphabet-index alphanum/alphabet/index)
    (define simple
      (make default-alphabet default-alphabet-index #\+))

    (values generic simple make)))
