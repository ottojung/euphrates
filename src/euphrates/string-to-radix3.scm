;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (string->radix3 base s)
  (define-values (pref signstring rest) (string-split-3 #\- s))
  (define nosign (if (string-null? signstring) pref rest))
  (define-values (whole dot fract) (string-split-3 #\. nosign))
  (define-values (non-repeating lpr repeating+1) (string-split-3 #\( fract))

  (when (string-null? s)
    (raisu* :from "string->radix3"
            :type 'empty-string
            :message "Radix string cannot be empty"
            :args (list s)))

  (unless (string-null? lpr)
    (unless (string-suffix? ")" s)
      (raisu* :from "string->radix3"
              :type 'type-error
              :message "Radix string initiated period section, but has not finished it"
              :args (list s))))

  (unless (string-null? signstring)
    (unless (string-null? pref)
      (raisu* :from "string->radix3"
              :type 'type-error
              :message (stringf "Radix string contains ~s not at the beginning, which is not allowed" (string #\-))
              :args (list pref s))))

  (define repeating
    (if (string-null? lpr) ""
        (substring repeating+1 0 (- (string-length repeating+1) 1))))

  (define basevector
    (radix3:parse-basevector base))
  (define basevector/reversed
    (alist->hashmap
     (map cons
          (vector->list basevector)
          (iota (vector-length basevector)))))

  (define (string->radix-list str)
    (map
     (lambda (c)
       (hashmap-ref
        basevector/reversed c
        (raisu* :from "string->radix3"
                :type 'type-error
                :message (stringf "Radix string contains a character not from base: ~s" c)
                :args (list c s str))))
     (string->list str)))

  (define sign (if (string-null? signstring) 1 -1))
  (define intpart (string->radix-list whole))
  (define fracpart (string->radix-list non-repeating))
  (define period (string->radix-list repeating))

  (radix3:constructor sign intpart fracpart period basevector))
