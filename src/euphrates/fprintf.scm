;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (fprintf port format-string . objects)
  (let loop ((format-list (string->list format-string))
             (objects objects))
    (cond ((null? format-list) (values))
          ((char=? (car format-list) #\~)
           (if (null? (cdr format-list))
               (error 'format "Incomplete escape sequence")
               (case (cadr format-list)
                 ((#\a)
                  (if (null? objects)
                      (error 'format "No value for escape sequence")
                      (begin
                        (display (car objects) port)
                        (loop (cddr format-list) (cdr objects)))))
                 ((#\s)
                  (if (null? objects)
                      (error 'format "No value for escape sequence")
                      (begin
                        (write (car objects) port)
                        (loop (cddr format-list) (cdr objects)))))
                 ((#\%)
                  (newline port)
                  (loop (cddr format-list) objects))
                 ((#\~)
                  (write-char #\~ port)
                  (loop (cddr format-list) objects))
                 (else
                  (error 'format "Unrecognized escape sequence")))))
          (else (write-char (car format-list) port)
                (loop (cdr format-list) objects)))))
