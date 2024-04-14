;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(cond-expand
 (guile

  (define-syntax get-current-source-file-path
    (syntax-rules ()
      ((_ . args)
       (cdr
        (assq
         'filename
         (current-source-location))))))

  )

 (racket

  (define-macro (get-current-source-file-path)
    '(path->string
      (build-path
       (this-expression-source-directory)
       (this-expression-file-name))))

  ))

