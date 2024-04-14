;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (make-directories path)

  (cond-expand
   (guile
    (define mk-single-dir mkdir)
    )
   (racket
    (define mk-single-dir make-directory)
    ))

  (define parts (string-split/simple path #\/))
  (list-fold
   (acc #f)
   (i parts)
   (let* ((path0 (if acc (append-posix-path acc i) i))
          (path (if (string-null? path0) "/" path0)))
     (unless (file-or-directory-exists? path)
       (mk-single-dir path))
     path)))
