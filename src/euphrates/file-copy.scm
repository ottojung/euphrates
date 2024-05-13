;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (file-copy original-path result-path)
  (call-with-input-file original-path
    (lambda (input-port)
      (define buff-size 4096)
      (define buffer (make-bytevector buff-size))
      (call-with-output-file result-path
        (lambda (output-port)
          (let loop ()
            (define bytes-read (read-bytevector! buffer input-port))
            (unless (eof-object? bytes-read)
              (when (and bytes-read (> bytes-read 0))
                (write-bytevector buffer output-port 0 bytes-read)
                (loop)))))))))
