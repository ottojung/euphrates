;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:simple:initialize-lexer
         parser-struct input)

  (define lexer
    (parselynn:simple-struct:lexer parser-struct))

  (define lexer-result
    (cond
     ((string? input)
      (parselynn:folexer:run-on-string lexer input))
     ((port? input)
      (parselynn:folexer:run-on-char-port lexer input))
     (else
      (raisu* :from "parselynn:simple:run/with-error-handler"
              :type 'bad-input-type
              :message "Bad input type, expected string or character port"
              :args (list input)))))

  (define lexer-iterator
    (parselynn:folexer-result:as-iterator lexer-result))

  lexer-iterator)
