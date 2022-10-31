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

%var string-plus-encode
%var string-plus-encode/generic

%use (alphanum/alphabet alphanum/alphabet/index) "./alphanum-alphabet.scm"
%use (convert-number-base/generic) "./convert-number-base.scm"

;; NOTE: this is like the uri-encoding, but simpler (I think) and compresses better.
(define-values (string-plus-encode/generic string-plus-encode)
  (let ()
    (define (generic s alphabet in-alphabet? maxcode plus-char)
      (define len (string-length s))
      (define alen (vector-length alphabet))
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
                      (display plus-char port)
                      (display
                       (list->string
                        (convert-number-base/generic
                         alphabet alen
                         (tointeger alphabet alen maxcode ch)))
                       port)
                      (unless (= len counter)
                        (display plus-char port)))))
              s)))
          s))

    (define default-alphabet alphanum/alphabet)
    (define default-alphabet-index alphanum/alphabet/index)
    (define default-alphabet-maxcode
      (let loop ((m 0) (i (- (vector-length default-alphabet) 1)))
        (if (< i 0) m
            (loop
             (let* ((c (vector-ref default-alphabet i))
                    (code (char->integer c)))
               (max code m))
             (- i 1)))))

    (define (tointeger alphabet alen maxcode ch)
      (define code (char->integer ch))
      (cond
       ((<= code maxcode) code)
       ((<= code (+ maxcode alen))
        (char->integer (vector-ref alphabet (- code maxcode 1))))
       (else (- code alen))))

    (define (simple s)
      (generic s default-alphabet default-alphabet-index default-alphabet-maxcode #\+))

    (values generic simple)))
