;;;; Copyright (C) 2020, 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; `readf' is usually `read-char' or `read-byte'
(define read-all-port
  (case-lambda
   ((port)
    (read-all-port port read-char))
   ((port readf)
    (read-all-port port readf list->string))
   ((port readf collect)
    (let loop ((result '()) (chr (readf port)))
      (if (eof-object? chr)
          (collect (reverse result))
          (loop (cons chr result) (readf port)))))))
