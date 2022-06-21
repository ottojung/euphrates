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

%run guile

%var url-get-path

%use (string-split-3) "./string-split-3.scm"

(define (url-get-path url)
  (define-values (protocol _sep rest)
    (string-split-3 "://" url))

  (if (string-null? _sep) #f
      (let ()
        (define-values (hostname _slash rest2)
          (string-split-3 "/" rest))

        (if (string-null? _slash) "/"
            (string-append _slash rest2)))))
