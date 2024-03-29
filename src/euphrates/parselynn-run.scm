;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn-run parser-struct token-iterator)
  (define (error-procedure type message-fmt token)
    (raisu* :type 'parse-error
            :message (stringf message-fmt token)
            :args (list type token)))

  (parselynn-run/with-error-handler
   parser-struct error-procedure token-iterator))
