;;;; Copyright (C) 2022  Otto Jung, 1997,2001,2002,2010,2011,2012,2013,2014,2019-2021 Free Software Foundation, Inc.
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

%var uri-encode

;; NOTE: taken from Guile compiler from "module/web/uri.scm"

;; According to RFC 3986

%use (uri-safe/alphabet/index) "./uri-safe-alphabet.scm"

%for (COMPILER "guile")

(use-modules
 ((ice-9 iconv)
  #:select (bytevector->string
            string->bytevector)))

(use-modules
 ((rnrs bytevectors)
  #:select (bytevector-length
            bytevector-u8-ref)))

%end

(define uri-encode
  (case-lambda
   ((str) (uri-encode str "utf-8"))
   ((str encoding)
    (if (string-index str (negate uri-safe/alphabet/index))
        (call-with-output-string
         (lambda (port)
           (string-for-each
            (lambda (ch)
              (if (uri-safe/alphabet/index ch)
                  (display ch port)
                  (let* ((bv (string->bytevector (string ch) encoding))
                         (len (bytevector-length bv)))
                    (let loop ((i 0))
                      (if (< i len)
                          (let ((byte (bytevector-u8-ref bv i)))
                            (display #\% port)
                            (when (< byte 16)
                              (display #\0 port))
                            (display (string-upcase (number->string byte 16))
                                     port)
                            (loop (+ 1 i))))))))
            str)))
        str))))
