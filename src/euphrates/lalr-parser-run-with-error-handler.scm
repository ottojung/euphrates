;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser-run/with-error-handler
         parser-struct errorp token-iterator)
  (define code (lalr-parser-struct:code parser-struct))
  (define actions (lalr-parser-struct:actions parser-struct))
  (define compiled (eval code (environment '(scheme base))))
  ((compiled actions) token-iterator errorp))
