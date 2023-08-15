;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; These are the same as SRFI-88 (forward) keywords, but reversed.
;; Examples include :option1 and :key.

(define (looks-like-an-unquoted-rkeyword? s)
  (let ((n (string-length s)))
    (and (> n 1)
         (char=? (string-ref s 0) #\:))))

(define (rkeyword? obj)
  (and (symbol? obj)
       (looks-like-an-unquoted-rkeyword?
        (symbol->string obj))))

(define (rkeyword->string k)
  (let* ((s (symbol->string k))
         (n (string-length s)))
    (substring s 1 n)))

(define (string->rkeyword s)
  (let ((s-colon (string-append ":" s)))
    (if (looks-like-an-unquoted-rkeyword? s-colon)
        (string->symbol s-colon)
        (raisu* :type 'type-error
                :message "The input string does not encode an rkeyword"
                :args (list s)))))
