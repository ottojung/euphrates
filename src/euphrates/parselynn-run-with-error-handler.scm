;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn-run/with-error-handler
         parser-struct errorp token-iterator)
  (define maybefun (parselynn:core:struct:maybefun parser-struct))
  (if maybefun
      (maybefun token-iterator errorp)
      (let ()
        (define code (parselynn:core:struct:code parser-struct))
        (define actions (parselynn:core:struct:actions parser-struct))
        (define compiled (eval code (parselynn:get-compilation-environment)))
        ((compiled actions) token-iterator errorp))))
