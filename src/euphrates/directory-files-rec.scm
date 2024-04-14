;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; Returns object like this:
;;    ((fullname name dirname1 dirname2 dirname3...
;;     (fullname name ....
;;
;;  where dirname1 is the parent dir of the file


(cond-expand
 (guile

  (define directory-files-rec
    (case-lambda
     ((directory) (directory-files-rec #f directory))
     ((include-directories? directory)
      (define iter
    (directory-files-depth-iter include-directories? +inf.0 directory))

      (let loop ((buf '()))
    (define x (iter))
    (if x
            (loop (cons x buf))
            buf)))))

  )

 (racket

  (define [directory-files-rec directory]
    (define (tostring path)
      (case path
    ((same) directory)
    (else (path->string path))))

    (fold-files
     (lambda [f type ctx]
       (cons (map tostring
                  (cons f (reverse (explode-path f))))
             ctx))
     '()
     directory))

  ))
