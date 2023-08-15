;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; These are the SRFI-88 (forward) keywords.
;; Originally published on: https://github.com/scheme-requests-for-implementation/srfi-88/blob/master/contrib/srfi/88.sld
;;  by Arthur Gleckeler

(define (looks-like-an-unquoted-fkeyword? s)
  (let ((n (string-length s)))
    (and (> n 1)
         (char=? (string-ref s (- n 1)) #\:))))

(define (fkeyword? obj)
  (and (symbol? obj)
       (looks-like-an-unquoted-fkeyword?
        (symbol->string obj))))

(define (fkeyword->string k)
  (let* ((s (symbol->string k))
         (n (string-length s)))
    (substring s 0 (- n 1))))

(define (string->fkeyword s)
  (let ((s-colon (string-append s ":")))
    (if (looks-like-an-unquoted-fkeyword? s-colon)
        (string->symbol s-colon)
        (raisu* :type 'type-error
                :message "The input string does not encode an fkeyword"
                :args (list s)))))
