;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; if `(map-fn line i)` returns #f then `line` is skipped
;; path is either a file path or an input port

(cond-expand
 (guile

  (define read/lines
    (case-lambda
     ((path)
      (define p (if (port? path) path (open path O_RDONLY)))
      (define ret
    (let loop ()
          (define line (read-line p))
          (cond
           ((eof-object? line) '())
           (else (cons line (loop))))))
      (when (string? path)
    (close-port p))
      ret)
     ((path map-fn)
      (define p (if (port? path) path (open path O_RDONLY)))
      (let loop ((i 0))
    (define line (read-line p))
    (if (eof-object? line) '()
            (let ((maped (map-fn line i)))
              (if maped
                  (cons maped (loop (+ 1 i)))
                  (loop (+ 1 i)))))))))

  ))


