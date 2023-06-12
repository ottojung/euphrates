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



;; Calls `fun' ob objects like this:
;;   (fullname name dirname1 dirname2 dirname3...)
;;   (fullname name ....)
;;
;;  where dirname1 is the parent dir of the file


(define directory-files-depth-foreach
  (case-lambda
   ((depth fun directory)
    (directory-files-depth-foreach #f depth fun directory))
   ((include-directories? depth fun directory)
    (define iter
      (directory-files-depth-iter include-directories? depth directory))

    (let loop ()
      (define x (iter))
      (if x
          (begin (fun x) (loop))
          (when #f #t))))))
