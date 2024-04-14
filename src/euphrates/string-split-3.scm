;;;; Copyright (C) 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (string-split-3 delimiter str)
  (define (string-split-first/lambda predicate str)
    (define lst (string->list str))
    (let loop ((buf lst) (ret '()))
      (if (null? buf) (values str "" "")
          (let ((cur (car buf)))
            (if (predicate cur)
                (values (list->string (reverse ret))
                        (list->string (list cur))
                        (list->string (cdr buf)))
                (loop (cdr buf) (cons cur ret)))))))

  (define (string-split-first/string delimiter str)
    (define lst (string->list str))
    (define len (length delimiter))
    (let loop ((buf lst) (ret '()))
      (if (null? buf) (values str "" "")
          (if (list-prefix? delimiter buf)
              (values (list->string (reverse ret))
                      (list->string delimiter)
                      (list->string (list-drop-n len buf)))
              (loop (cdr buf) (cons (car buf) ret))))))

  (cond
   ((string? delimiter) (string-split-first/string (string->list delimiter) str))
   ((char? delimiter) (string-split-first/string (list delimiter) str))
   ((procedure? delimiter) (string-split-first/lambda delimiter str))
   (else (raisu 'delimiter-must-be-string-or-char-or-procedure delimiter))))
