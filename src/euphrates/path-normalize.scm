;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(cond-expand
 (guile
  (define-module (euphrates path-normalize)
    :export (path-normalize)
    :use-module ((euphrates string-split-simple) :select (string-split/simple))
    :use-module ((euphrates list-drop-while) :select (list-drop-while)))))



(define (path-normalize path)
  (define parts (string-split/simple path #\/))
  (define parts-filt
    (filter
     (lambda (part)
       (not
        (or (string-null? part)
            (equal? "." part))))
     parts))

  (define new-parts
    (let loop ((todo parts-filt) (buf '()))
      (if (null? todo)
          (reverse buf)
          (let* ((cur (car todo))
                 (new-buf
                  (if (equal? cur "..")
                      (if (or (null? buf)
                              (equal? (car buf) ".."))
                          (cons ".." buf)
                          (cdr buf))
                      (cons cur buf))))
            (loop (cdr todo) new-buf)))))

  (define rooted-parts
    (if (string-prefix? "/" path)
        (list-drop-while
         (lambda (part) (equal? part ".."))
         new-parts)
        new-parts))

  (define joined
    (string-join rooted-parts "/"))

  (if (string-prefix? "/" path)
      (string-append "/" joined)
      joined))
